module Admin::AdminsiteApplicationHelper

  def format_response_value(value)
    response = '<td>'
    if is_url?(value)
      response += link_to(value,value, target: :blank)
      response += "<br/>#{image_tag(value)}" if is_image?(value)
    else
      response += h value
    end
    response + '</td>'
  end

  def is_url?(value)
    value.is_a?(String) && value.match(/\A[\/]|\Ahttp[s]*:/)
  end

  def image_extensions
    %w(.png .gif .jpg .tif)
  end

  def is_image?(path)
    image_extensions.include?( File.extname(path).split('?').first.try(:downcase) )
  end

  def error_messages_for(obj)
    return if obj.errors.blank?
    msgs = obj.errors.full_messages.collect{|msg| "<li>#{ h msg }</li>" }
    raw ['<ul>', msgs, '</ul>'].flatten.join
  end

  def menu_item(label, url, current_controller = '', klass = nil, method = nil)
    current = %Q{id="current"} if url == request.fullpath
    klass_string = %Q{class="#{klasses(current_controller, klass)}"} if klass.present?
    link = link_to(label, url, method: method)
    raw "<li #{[current, klass_string].join(' ')}>#{link}</li>"
  end

  def klasses(current_controller, klass)
    [].tap do |result|
      result << klass    if klass.present?
      result << 'active' if current_controller == controller.controller_name
    end.join(' ')
  end

  def label_resource
    @resource.send(resource_admin_config.label_attribute)
  end

  def label_resource_class
    resource_class.name.underscore.gsub('_', ' ')
  end

  def label_resource_class_plural
    label_resource_class.pluralize
  end

  def link_to_back(text, path)
    link_to text, path, :class => 'back'
  end

  def link_to_new(text, path)
    link_to text, path, :class => 'add'
  end

  def link_to_show(resource_base_path, resource)
    link_to image_tag('adminsite/admin/magnifier.png', :size => '16x16'), "#{resource_base_path}/#{resource.id}", target: :blank
  end

  def link_to_edit(resource_base_path, resource)
    link_to image_tag('adminsite/admin/pencil.png', :size => '16x16'), "#{resource_base_path}/#{resource.id}/edit"
  end

  def link_to_destroy(resource_base_path, resource)
    link_to image_tag('adminsite/admin/cross.png', :size => '16x16'), "#{resource_base_path}/#{resource.id}", :confirm => 'Are you sure?', :method => :delete
  end

  def display_referenced_resource(resource)
    link_to resource.title, send("edit_admin_#{resource.class.name.underscore.gsub('/','_')}_path", resource.id)
  end
end
