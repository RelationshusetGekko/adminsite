require 'net/http'

namespace :adminsite do

  desc "Create an admin account"
  task :create_admin => :environment do

    name = ENV['NAME'] || 'Admin'
    email = ENV['EMAIL'] || 'admin@adminsite.dk'
    if Rails.env.development?
      password = "password"
    else
      password = Digest::MD5.hexdigest(Time.now.to_s)[0..5]
    end

    Adminsite::AdminUser.create!( :name                  => name,
                                  :email                 => email,
                                  :password              => password,
                                  :password_confirmation => password)
    puts "#{'*'*70}"
    puts "Done! You can access the admin interface at http://yourapp_url/admin"
    puts "I have created an administrator with these credentials:"
    puts ""
    puts "Name:     #{name}"
    puts "e-mail:   #{email}"
    puts "password: #{password}"
    puts ""
    puts "For Mosso Cloud Files integration and Protected pages"
    puts "please refer to the README file in this gem root folder"
    puts "#{'*'*70}"
  end

  def path_to_seed_sub_dir
    Rails.root.join("db","seeds")
  end

  def path_to_assets_seed_sub_dir
    path_to_seed_sub_dir.join("assets")
  end

  namespace :seed do
    namespace :assets do

      desc "Clear assets and load them from seeds again"
      task :reload => [:clear, :load]

      desc "Load assets from seed data"
      task :load => :environment do
        files = Dir.glob("#{Rails.root}/db/seeds/assets/*.*")

        files.each do |file|
          ext = File.extname(file)
          unless %w[.html .css].include?(ext)
            puts file
            Adminsite::FileAsset.create(:attachment => File.new(file))
          end
        end
      end

      desc "Overwrite assets in seed data"
      task :dump => :environment do
        FileUtils.mkdir_p(path_to_assets_seed_sub_dir)
        Adminsite::FileAsset.all.each do |file_asset|
          target_file = "#{path_to_assets_seed_sub_dir}/#{file_asset.attachment_file_name}"
          if file_asset.attachment.options[:storage] == :filesystem
            src_file = file_asset.attachment.path
            FileUtils.cp(src_file, target_file)
          else
            src_file = file_asset.attachment.url(:original, false)
            File.open(target_file, 'w') do |file|
              response = Net::HTTP.get_response(URI.parse(src_file))
              file.write response.body
            end
          end
        end
      end

      desc "Clear out all assets"
      task :clear => :environment do
        Adminsite::FileAsset.destroy_all
      end
    end

    namespace :page_layouts do

      desc "Clear all page layouts and load them from seeds again"
      task :reload => [:clear, :load]

      desc "Load page layouts from seeds"
      task :load => :environment do
        YAML::load_file("#{Rails.root}/db/seeds/page_layouts.yml").each do |page_layout|
          Adminsite::PageLayout.create!(page_layout)
        end
      end

      desc "Overwrite page_layouts in seeds"
      task :dump => :environment do
        FileUtils.mkdir_p(path_to_seed_sub_dir)
        File.open("#{Rails.root}/db/seeds/page_layouts.yml", 'w') do |file|
          attributes = Adminsite::PageLayout.all.map{|page_layout|
            page_layout.attributes.except('id', 'created_at', 'updated_at')
          }
          begin
            file.write attributes.to_yaml
          rescue Exception => e
            raise "#{e.message}:\n#{attributes.inspect}"
          end
        end
      end

      desc "Clear out all page layouts"
      task :clear => :environment do
        Adminsite::PageLayout.destroy_all
      end
    end

    namespace :pages do

      desc "Clear all pages and load them from seeds again"
      task :reload => [:clear, :load]

      desc "Load pages from seeds"
      task :load => :environment do
        YAML::load_file("#{Rails.root}/db/seeds/pages.yml").each do |page|
          page_layout = Adminsite::PageLayout.find_by_title(page["page_layout_title"])
          Adminsite::Page.create!(page.except("page_layout_title").merge({:page_layout_id => page_layout.id}))
        end
      end

      desc "Overwrite pages in seeds"
      task :dump => :environment do
        File.open("#{Rails.root}/db/seeds/pages.yml", 'w') do |file|
          FileUtils.mkdir_p(path_to_seed_sub_dir)
          attributes = Adminsite::Page.all.map{|page|
            page.attributes.except('id', 'created_at', 'updated_at', 'page_layout_id').merge({'page_layout_title' => page.page_layout.title})
          }
          file.write attributes.to_yaml
        end
      end

      desc "Clear out all pages"
      task :clear => :environment do
        Adminsite::Page.destroy_all
      end
    end
  end
end