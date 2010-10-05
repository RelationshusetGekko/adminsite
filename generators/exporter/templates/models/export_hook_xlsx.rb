tmp_filename = filename + ".partial"

file = default_path_to_export.join(filename)
tmp_file = default_path_to_export.join(tmp_filename)

SimpleXlsx::Serializer.new(tmp_file) do |doc|
  doc.add_sheet "<%= class_name %>" do |sheet|
    attr_lst = <%= class_name %>::Exports.full
    sheet.add_row(attr_lst)
    <%= class_name %>.all.each do |profile|
      values = attr_lst.collect { |attr| profile.try(attr).inspect }
      sheet.add_row(values)
    end
  end
end
FileUtils.rm Dir.glob(default_path_to_export.join("*.xml*"))
FileUtils.mv(tmp_file, file)