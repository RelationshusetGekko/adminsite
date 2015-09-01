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

  def current_admin_menu
    @current_admin_menu ||= params[:admin_menu]
  end

  def menu_item(label, url, child_controllers = [], klasses = nil, method = nil, admin_menu = label)
    link = link_to(label, "#{url}?admin_menu=#{admin_menu}", method: method, )
    result = raw "<li class='#{html_classes(url, nil, klasses, admin_menu, label )}'>#{link}</li>"

    if current_url?(url, label) || ( child_controller_active?(child_controllers) && current_admin_menu == admin_menu)
      child_controllers.each do |child_controller|
        child_menu = content_menu_item(child_controller, admin_menu, nil, nil )
        content_for(:content_menu, child_menu)
      end
    end
    result
  end

  def content_menu_item(current_controller, admin_menu, klasses, method )
    url = eval("admin_#{current_controller}_path")
    label = current_controller.titlecase
    link = link_to(label, "#{url}?admin_menu=#{admin_menu}", method: method, )
    raw "<li class='#{html_classes(url, current_controller, klasses, admin_menu )}'>#{link}</li>"
  end

  def current_url?(url, label = '')
    if label.present?
      return request.fullpath == "#{url}?admin_menu=#{label}"
    else
      return request.fullpath == url
    end
  end

  def child_controller_active?(child_controllers)
    child_controllers.include?(controller.controller_name)
  end

  def html_classes(url, current_controller, klasses = nil, admin_menu = '', label = '')
    result = []
    result |= [klasses].flatten if klasses.present?
    result |= ['current'] if current_url?(url, admin_menu)
    result |= ['active']  if current_admin_menu == label || current_controller == controller.controller_name
    result.join(' ')
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

  def link_to_back(text, path = admin_resource_path)
    link_to text, path, :class => 'back'
  end

  def link_to_new(text, path = admin_resource_path(nil, :new) )
    link_to text, path, :class => 'add'
  end

  def link_to_show(resource)
    link_to image_tag('adminsite/admin/magnifier.png', :size => '16x16'), admin_resource_path(resource.id), target: :blank
  end

  def link_to_edit(resource)
    link_to image_tag('adminsite/admin/pencil.png', :size => '16x16'), admin_resource_path(resource.id, :edit)
  end

  def link_to_destroy(resource)
    link_to image_tag('adminsite/admin/cross.png', :size => '16x16'), admin_resource_path(resource.id), :confirm => 'Are you sure?', :method => :delete
  end

  def display_resource_value(resource, attr)
    value = nil
    attr.to_s.split('.').each{|a| value = (value || resource).send(a) }
    display_referenced_resource(value) if value.is_a?(ActiveRecord::Base)
    format_response_value(value).html_safe
  end

  def display_referenced_resource(resource)
    link_to resource.title, send("edit_admin_#{resource.class.name.underscore.gsub('/','_')}_path", resource.id)
  end
end
