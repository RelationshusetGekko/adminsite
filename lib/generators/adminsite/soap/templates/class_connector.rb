class <%= class_name.camelize %> <  SoapBase<%= class_name.camelize %>
  class << self

    private

    def kind
      'login'
    end

    def soap_input_name
      "Login"
    end

    def soap_payload_key
      :property
    end

    def soap_result_key
      :login_result
    end

    def soap_response_key
      :login_response
    end

    def soap_input_attributes
      nil
    end

  end
end
