module Admin::AdminsiteApplicationHelper

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

  def is_image?(path)
    image_extensions.include?( File.extname(path).split('?').first.try(:downcase) )
  end

  def image_extensions
    %w(.png .gif .jpg .tif)
  end

  def error_messages_for(obj)
    return if obj.errors.blank?
    msgs = obj.errors.full_messages.collect{|msg| "<li>#{ h msg }</li>" }
    raw ['<ul>', msgs, '</ul>'].flatten.join
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
    link_to image_tag('adminsite/admin/magnifier.png', :size => '16x16'), admin_resource_path(resource.id), target: '_blank' if can?(:read, resource)
  end

  def link_to_edit(resource)
    link_to image_tag('adminsite/admin/pencil.png', :size => '16x16'), admin_resource_path(resource.id, :edit) if can?(:edit, resource)
  end

  def link_to_destroy(resource)
    link_to image_tag('adminsite/admin/cross.png', :size => '16x16'), admin_resource_path(resource.id), data: { :confirm => 'Are you sure?'} , :method => :delete if can?(:destroy, resource)
  end

  def display_resource_value(resource, attr, add_td_wrappers = true)
    value = nil
    attr.to_s.split('.').each{|a| value = (value || resource).send(a) }
    value = display_referenced_resource(value, false) if value.is_a?(ActiveRecord::Base)
    if value.is_a?(ActiveRecord::Associations::CollectionProxy) or value.is_a?(Array)
      value = value.collect do |r|
        if r.is_a?(ActiveRecord::Base)
          display_referenced_resource(r, false)
        else
          r
        end
      end.join(', ')
    end
    format_response_value(value, add_td_wrappers).html_safe
  end

  def display_referenced_resource(resource, add_td_wrappers = true)
    label_attr = Adminsite::AdminConfig::Base.admin_config_of_class(resource.class, nil, current_adminsite_admin_user).label_attribute(resource)
    label = display_resource_value(resource, label_attr, add_td_wrappers)
    begin
      if can?(:edit, resource)
        link_to label, send("edit_admin_#{resource.class.name.underscore.gsub('/','_')}_path", resource.id, admin_menu: params[:admin_menu])
      elsif can?(:read, resource)
        link_to label, send("admin_#{resource.class.name.underscore.gsub('/','_')}_path", resource.id, admin_menu: params[:admin_menu])
      else
        label
      end
    rescue
      return label
    end
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
