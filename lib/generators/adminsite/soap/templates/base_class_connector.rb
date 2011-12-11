class SoapBase<%= class_name.camelize %>
  class << self

    def fetch(args)
      get(args, "get_#{kind}")
    end

    def update(args)
      get(args, "update_#{kind}", true)
    end

    private

    def perform_request(soapified_data)
      client.request(soap_method_name) do |soap|
        soap.version = 2
        soap.input = [soap_input_name,  {"xmlns" => "http://tempuri.org/"}]
        soap.body  = soapified_data
      end
    end

    def get(soapified_data, method_name, update = false)
      result_info = nil
      begin
        response = perform_request(soapified_data)

        # log response and parameters we have sent
        result_info = response.to_hash[soap_response_key][soap_result_key]
        audit(soapified_data, result_info)

      rescue Exception => e
        HoptoadNotifier.notify(
              :error_class   => "SoapBase<%= class_name.camelize %>::#{kind.camelize}",
              :error_message => "Soap API triggered an exception: #{e.message} when calling #{method_name}",
              :parameters    => { :soapified_data => soapified_data.inspect,
                                  :exception_message => e.message }
              )

        audit(soapified_data, "Exception: #{e.message}")

        # raise e
        return {:result => nil, :error => e.message}
      end

      if !success?(result_info)
        HoptoadNotifier.notify(:error_class    => 'SoapBase<%= class_name.camelize %>::#{kind.camelize}',
                               :error_message  => "Error #{soapified_data.inspect} when calling #{method_name}",
                               :parameters     => { :soapified_data => soapified_data.inspect,
                                                    :result_info => result_info.inspect,
                                                    :response => { :content => response.inspect,
                                                                   :http_error_message => response.http_error.try(:message),
                                                                   :http_code => response.http.code,
                                                                   :soap_fault_message =>  response.soap_fault.try(:message)
                                                                 }
                                                  } )
        return {:result => nil, :error => ""}
      end

      return {:result => result_info, :error => nil}
    end

    def client
      result = Savon::Client.new do |wsdl|
        wsdl.endpoint = wsdl_endpoint
        wsdl.namespace = wsdl_namespace
      end
      result.http.headers["Content-Type"] = "text/xml;charset=UTF-8"
      result
    end

    def audit(soapified_data, result)
      logger.info("#{Time.zone.now.to_s(:db)}: #{result.inspect} -- #{soapified_data.inspect}")
    end

    def logger
      Logger.new(ApplicationSettings::RAILS_ROOT.join 'log', "soap_connector_#{kind}.log")
    end

    # To be subclassed

    def soap_input_attributes
      raise 'Implement in subclass!'
    end

    def wsdlfile
      ApplicationSettings::SOAP::WSDL_FILE
    end

    def wsdl_endpoint
      ApplicationSettings::SOAP::WSDL_ENDPOINT
    end

    def wsdl_namespace
      'http://tempuri.org/'
    end

    def kind
      raise 'Implement in subclass!'
    end

    def soap_input_name
      raise 'Implement in subclass!'
    end

    def soap_method_name
      "#{wsdl_namespace}#{soap_input_name}"
    end

    def soap_payload_key
      raise 'Implement in subclass!'
    end

    def soap_response_key
      raise 'Implement in subclass!'
    end

    def soap_result_key
      raise 'Implement in subclass!'
    end

    def error_message(result_info)
      ""
    end

    def success?(result_info)
      return false if result_info.blank?
      true
    end

  end
end
