module Admin::AdminsiteApplicationHelper
  def error_messages_for(obj)
    return if obj.errors.nil?
    msgs = obj.errors.full_messages.collect{|msg| "<li>#{ h msg }</li>" }
    raw ['<ul>', msgs, '</ul>'].flatten.join
  end

  def menu_item(label, url, klass = nil)
    current = %Q{id="current"} if url == request.fullpath
    klass_string = %Q{class="#{klass}"} if klass.present?
    raw "<li #{h [current, klass_string].join(' ')}><a href='#{h url}'>#{h label}</a></li>"
  end
end
