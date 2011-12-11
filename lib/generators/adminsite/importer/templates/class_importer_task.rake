namespace :app do
  namespace :<%= class_name.underscore %> do

    desc 'Load <%= class_name %> data'
    task :import => :environment do

      puts "Before import, we have #{<%= class_name %>.count} <%= class_name.underscore %>s in DB"

      counter = 0;
      path = Rails.root.join('db', 'seeds', '<%= class_name.underscore %>s')
      <%= class_name %>.transaction do
        Dir[path.to_s + "/**"].each do |filename|
          basename = File.basename(filename)
          puts "Import #{basename}"
          row_index = 0
          import_attributes = <%= class_name %>.new.attributes.keys
          FasterCSV.foreach(filename,
                            :col_sep    => ';',
                            :encoding   => 'N',
                            :converters => :utf8,
                            :headers    => true,
                            :header_converters => [:utf8, :downcase]) do |row|
            row_index += 1
            begin
              <%= class_name.underscore %> = <%= class_name %>.create!(row.to_hash)
              # <%= class_name.underscore %>.update_attributes(:import_file => basename)
            rescue Exception => e
              raise "Error on row #{row_index}: #{e.message}"
            end
          end
          counter += row_index
        end
      end
      puts "Imported #{counter} rows"
    end
  end
end
