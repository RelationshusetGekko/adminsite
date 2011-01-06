module Admin::AdminsiteApplicationHelper
  def error_messages_for(obj)
    return if obj.errors.nil?
    msgs = obj.errors.full_messages.collect{|msg| "<li>#{ h msg }</li>" }
    raw ['<ul>', msgs, '</ul>'].flatten.join
  end

  def menu_item(label, url, current_controller = '', klass = nil)
    current = %Q{id="current"} if url == request.fullpath
    klass_string = %Q{class="#{klasses(current_controller, klass)}"} if klass.present?
    raw "<li #{[current, klass_string].join(' ')}><a href='#{h url}'>#{h label}</a></li>"
  end

  def klasses(current_controller, klass)
    [].tap do |result|
      result << klass    if klass.present?
      result << 'active' if current_controller == controller.controller_name
    end.join(' ')
  end
end
