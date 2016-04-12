module Admin::AdminsiteApplicationHelper

  def column_of_attr(search_attr)
    return if search_attr.blank?
    resource_class.columns.each{|c| return c if c.name == search_attr.to_s.downcase }
    nil
  end

  def input_type_of_column(column)
    case
    when column.sql_type.match(/\Acharacter varying/)
      return :string
    when column.sql_type.match(/\Atimestamp/)
      return :date
    when column.sql_type.match(/\integer/)
      return :number
    else
      column.sql_type.try(:to_sym)
    end
  end

  def ransack_predicate_input_type(input_type)
    case input_type
    when :boolean
      return [:eq]
    when :text
      return [:eq, :cont]
    when :string
      return [:eq, :cont]
    when :date
      return [:lteq, :gteq]
    when :number
      return [:eq, :lteq, :gteq]
    else
      [:eq]
    end
  end

  def format_response_value(value, add_td_wrappers = true)
    value = value.url if defined?(PictureUploader) && value.is_a?(PictureUploader)
    response = ''
    response = '<td>' if add_td_wrappers
    if is_url?(value)
      response += link_to(value,value, target: '_blank')
      response += "<br>#{image_tag(value)}" if is_image?(value)
    else
      response += h value
    end
    if add_td_wrappers
      response + '</td>'
    else
      response
    end
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

  def recognize_path(path)
    return {} if path.try(:strip).blank?
    begin
      return Adminsite::Engine.routes.recognize_path(path) # '/admin/profiles'
      return Rails.application.routes.recognize_path(path)
    rescue Exception => e
    end
  end

  def current_admin_menu
    @current_admin_menu ||= params[:admin_menu]
  end

  def menu_item(label, url, child_controller_names = [], klasses = nil, method = nil, admin_menu = label)
    link = link_to(label, "#{url}?admin_menu=#{admin_menu}", method: method, )
    result = raw "<li class='#{html_classes(url, nil, klasses, admin_menu, label )}'>#{link}</li>"

    if current_url?(url, label) || ( child_controller_active?(child_controller_names) && current_admin_menu == admin_menu)
      child_controller_names.each do |child_controller_name|
        child_menu = content_menu_item(child_controller_name, admin_menu, nil, nil )
        content_for(:content_menu, child_menu)
      end
    end
    result
  end

  def content_menu_label(url, controller_name)
    menu_controller = recognize_path(url)[:controller]
    return controller_name.titlecase if menu_controller.blank?
    eval("#{menu_controller}_controller".classify).content_menu_label
  end

  def content_menu_item(controller_name, admin_menu, klasses, method )
    if controller_name != controller_name.pluralize
      url = eval("admin_#{controller_name}_index_path")
    else
      url = eval("admin_#{controller_name}_path")
    end
    link = link_to(content_menu_label(url, controller_name), "#{url}?admin_menu=#{admin_menu}", method: method, )
    raw "<li class='#{html_classes(url, controller_name, klasses, admin_menu )}'>#{link}</li>"
  end

  def current_url?(url, label = '')
    if label.present?
      return request.fullpath == "#{url}?admin_menu=#{label}"
    else
      return request.fullpath == url
    end
  end

  def child_controller_active?(child_controller_names)
    child_controller_names.include?(controller.controller_name)
  end

  def html_classes(url, controller_name, klasses = nil, admin_menu = '', label = '')
    result = []
    result |= [klasses].flatten if klasses.present?
    result |= ['current'] if current_url?(url, admin_menu)
    result |= ['active']  if current_admin_menu == label || controller_name == controller.controller_name
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
    link_to image_tag('adminsite/admin/magnifier.png', :size => '16x16'), admin_resource_path(resource.id), target: '_blank'
  end

  def link_to_edit(resource)
    link_to image_tag('adminsite/admin/pencil.png', :size => '16x16'), admin_resource_path(resource.id, :edit)
  end

  def link_to_destroy(resource)
    link_to image_tag('adminsite/admin/cross.png', :size => '16x16'), admin_resource_path(resource.id), data: { :confirm => 'Are you sure?'} , :method => :delete
  end

  def display_resource_value(resource, attr, add_td_wrappers = true)
    value = nil
    attr.to_s.split('.').each{|a| value = (value || resource).send(a) }
    value = display_referenced_resource(value) if value.is_a?(ActiveRecord::Base)
    if value.is_a?(ActiveRecord::Associations::CollectionProxy)
      value = value.collect do |r|
        label = Adminsite::AdminConfig::Base.admin_config_of_class(r.class, nil, current_adminsite_admin_user).label_attribute(r)
        display_resource_value(r, label, false)
      end.join(', ')
    end
    format_response_value(value, add_td_wrappers).html_safe
  end

  def display_referenced_resource(resource)
    link_to resource.title, send("edit_admin_#{resource.class.name.underscore.gsub('/','_')}_path", resource.id, admin_menu: params[:admin_menu])
  end

  def publish_form_input(form, form_input)
    options = {}
    if form_input.is_a?(Hash)
      attr_name = form_input.keys.first
      options = form_input[attr_name]
    else
      attr_name = form_input
    end
    form.input(attr_name, options).html_safe
  end

end
