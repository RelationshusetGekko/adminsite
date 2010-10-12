# Mostly pinched from http://github.com/ryanb/nifty-generators/tree/master

Rails::Generator::Commands::Base.class_eval do
  def file_contains?(relative_destination, line)
    File.read(destination_path(relative_destination)).include?(line)
  end
end

Rails::Generator::Commands::Create.class_eval do
  def append_to(file, line)
    logger.insert "#{line} appended to #{file}"
    unless options[:pretend] || file_contains?(file, line)
      File.open(file, "a") do |file|
        file.puts
        file.puts line
      end
    end
  end

  # Inspired by rails/railties/lib/rails_generator/commands.rb # route_resources
  def route_namespaced_resources(namespace, *resources)
    resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
    sentinel = 'ActionController::Routing::Routes.draw do |map|'
    logger.route "#{namespace}.resources #{resource_list}"
    unless options[:pretend]
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        "#{match}\n  map.namespace(:#{namespace}) do |#{namespace}|\n    #{namespace}.resources #{resource_list}\n  end\n"
      end
    end
  end

  # Taken from http://github.com/thoughtbot/clearance/blob/master/generators/clearance/lib/insert_commands.rb
  def insert_into(file, line)
    logger.insert "#{line} into #{file}"
    unless options[:pretend] || file_contains?(file, line)
      gsub_file file, /^(class|module|.*Routes).*$/ do |match|
        "#{match}\n  #{line}"
      end
    end
  end
end

Rails::Generator::Commands::Destroy.class_eval do
  def append_to(file, line)
    logger.remove "#{line} removed from #{file}"
    unless options[:pretend]
      gsub_file file, "\n#{line}", ''
    end
  end

  def route_namespaced_resources(namespace, *resources)
    # TODO
    # resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
    # look_for = "\n  map.resources #{resource_list}\n"
    # logger.route "map.resources #{resource_list}"
    # gsub_file 'config/routes.rb', /(#{look_for})/mi, ''
  end

  def insert_into(file, line)
    logger.remove "#{line} from #{file}"
    unless options[:pretend]
      gsub_file file, "\n  #{line}", ''
    end
  end
end

Rails::Generator::Commands::List.class_eval do
  def append_to(file, line)
    logger.insert "#{line} appended to #{file}"
  end

  def route_namespaced_resources(file, line)
    logger.insert "#{line} into #{file}"
  end

  def insert_into(file, line)
    logger.insert "#{line} into #{file}"
  end
end