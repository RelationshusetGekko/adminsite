class <%= class_name.camelize %>Export
  @queue = :<%= file_name %>_export

  class << self
    def perform(export_name_scope, file_type)
      begin
        Rails.logger.info("Received queued export job: #{Time.zone.now}")
        FileUtils.mkdir_p(default_path_to_export)
        case file_type.to_s
          when 'xlsx' : export_to_xlsx(export_name_scope)
          when 'csv'  : export_to_csv(export_name_scope)
        end
      rescue Exception => msg
        Rails.logger.debug(msg.to_s)
        raise msg
      end
    end

    def export_to_xlsx(export_name_scope)
      # TODO: As soon as SimpleXlsx get simpler remove the temp file dance
      file_type = 'xlsx'
      tmp_filename = filename(file_type) + ".partial"

      file = default_path_to_export.join(filename(file_type))
      tmp_file = default_path_to_export.join(tmp_filename)

      SimpleXlsx::Serializer.new(tmp_file) do |doc|
        doc.add_sheet "<%= class_name.camelize %>s" do |sheet|
          attr_lst = <%= class_name.camelize %>::Exports.full
          sheet.add_row(attr_lst)
          <%= class_name.camelize %>.send(export_name_scope).each do |<%= file_name %>|
            values = attr_lst.collect { |attr| <%= file_name %>.try(attr).to_s }
            sheet.add_row(values)
          end
        end
      end
      FileUtils.rm Dir.glob(default_path_to_export.join("*.xml*"))
      FileUtils.mv(tmp_file, file)
    end

    def export_to_csv(export_name_scope)
      file = default_path_to_export.join(filename('csv'))
      <%= class_name.camelize %>.send(export_name_scope).to_comma(:style    => :default,
                                               :filename => file)
    end

    def default_path_to_export
      Rails.root.join("db",
                      "data_exports",
                      "<%= file_name %>_exports")
    end

    def generated_export_files(ext)
      Dir.glob("#{default_path_to_export}/*.#{ext}").reverse
    end

    def filename(file_type)
      "<%= file_name %>s_#{Time.zone.now.to_s(:file_timestamp)}.#{file_type}"
    end
  end

end