class AdminsiteStatisticGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def run_generation
    puts "Setting up Adminsite statistic for #{class_name}"

    template  "class_statistic_module.rb", "app/models/#{class_name.downcase}/statistic.rb"
    template  "class_statistics_controller.rb", "app/controllers/admin/#{class_name.downcase}_statistics_controller.rb"
    template  "class_statistics_helper.rb", "app/helpers/admin/#{class_name.downcase}_statistics_helper.rb"

    template  "statistics/index.html.haml", "app/views/admin/#{class_name.downcase}_statistics/index.html.haml"
    template  "statistics/_progress.html.haml", "app/views/admin/#{class_name.downcase}_statistics/_progress.html.haml"
    template  "statistics/_progress_td.html.haml", "app/views/admin/#{class_name.downcase}_statistics/_progress_td.html.haml"

    # Gemfile
    inject_into_file "Gemfile", :after => /gem 'adminsite'.*\n/ do
      "gem 'memcache-client'\n"+
      "gem 'statistics'\n"
    end

    # Routes
    inject_into_file "config/routes.rb", :after => /\.routes\.draw do\s*\n/ do
      "  namespace :admin do\n    resources :#{class_name.downcase}_statistics, :only => [:index] \n  end\n"
    end

    # _Menu
    inject_into_file "app/views/admin/shared/_menu.haml", :before => /^.*destroy_admin_session_path/ do
      "    = menu_item '#{class_name.titlecase}-Statistic', admin_#{class_name.downcase}_statistics_path, '#{class_name.downcase}_statistic'\n"
    end

    # _Class Model
    inject_into_file "app/models/#{class_name.downcase}.rb", :after => /class #{class_name.titlecase} < ActiveRecord::Base\s*\n/ do
  "
  class << self
    def self.created_at_date(date)
      where(\"DATE(created_at) <= ?\", date)
    end
  end\n
  "
    end

  end
end