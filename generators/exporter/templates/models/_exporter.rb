class <%= class_name %>Exporter

  @queue = :<%= class_name %>_export

  class << self
    def perform()
        begin
          Rails.logger.info("Received queued <%= class_name %> export job: #{Time.zone.now}")

          FileUtils.mkdir_p(default_path_to_export)

          filename = get_new_filename

          #{Code}

        rescue Exception => msg
          Rails.logger.debug(msg.to_s)
          raise msg
        end
      end
    end

    def file_ext
      "xlsx"
    end

    def default_path_to_export
      Rails.root.join("db",
                      "exports",
                      "profile_exports")
    end

    def generated_export_files
      Dir.glob("#{default_path_to_export}/*.#{ProfileExport.file_ext}")
    end

    def get_new_filename
      "<%= class_name %>_#{Time.zone.now.to_s(:file_timestamp)}.#{ProfileExport.file_ext}"
    end

  end
end