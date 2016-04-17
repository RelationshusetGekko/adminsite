module Admin::AdminsiteMenuHelper

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
    result = ''
    child_menus = []

    child_controller_names_authorized = child_controller_names.select do |child_controller_name|
      controller_class_name = "#{child_controller_name}_controller".classify
      controller_class = eval("defined?(Adminsite::" + "#{controller_class_name}) ? Adminsite::#{controller_class_name} : Adminsite::Admin::#{controller_class_name}".classify)
      can?(:read, controller_class.new.authorize_resource_class)
    end

    if current_url?(url, label) || ( child_controller_active?(child_controller_names) && current_admin_menu == admin_menu)
      child_controller_names_authorized.each do |child_controller_name|
        child_menus << content_menu_item(child_controller_name, admin_menu, nil, nil )
      end
    end
    child_menus = child_menus.compact

    if child_controller_names_authorized.count > 0
      begin
        url_controller_class = "#{recognize_path(url)[:controller]}_controller".classify.constantize
        if !can?(:read, url_controller_class.new.authorize_resource_class)
          url = content_index_path(child_controller_names_authorized.first)
        end
      rescue
      end

      html_options = {method: method}
      html_options[:title] = current_adminsite_admin_user.email if klasses == 'log_out'
      link = link_to(label, "#{url}?admin_menu=#{admin_menu}", html_options)
      result = raw "<li class='#{html_classes(url, nil, klasses, admin_menu, label )}'>#{link}</li>"

      content_for(:content_menu, child_menus.join("\n").html_safe )
    end
    result
  end

  def content_index_path(controller_name)
    begin
      if controller_name != controller_name.pluralize
        eval("admin_#{controller_name}_index_path")
      else
        eval("admin_#{controller_name}_path")
      end
    rescue
    end
  end

  def content_index_link(controller_name, admin_menu, method = nil)
    path = content_index_path(controller_name)
    link_to(content_menu_label(path, controller_name), "#{path}?admin_menu=#{admin_menu}", method: method, )
  end

  def content_menu_label(url, controller_name)
    menu_controller = recognize_path(url)[:controller]
    return controller_name.titlecase if menu_controller.blank?
    eval("#{menu_controller}_controller".classify).content_menu_label
  end

  def content_menu_item(controller_name, admin_menu, klasses, method )
    link = content_index_link(controller_name, admin_menu, method )
    raw "<li class='#{html_classes(content_index_path(controller_name), controller_name, klasses, admin_menu )}'>#{link}</li>"
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

end