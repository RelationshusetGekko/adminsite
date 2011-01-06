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

  # SORTABLE TABLE
  def sort_th_class_helper(text, param)
    raw "<th #{h sort_td_class_helper(param)}>#{h sort_link_helper(text, param)}</th>"
  end
  def sort_td_class_helper(param)
    result = 'class="sortup"' if params[:sort] == param
    result = 'class="sortdown"' if params[:sort] == param + "_reverse"
    return result
  end
  def sort_link_helper(text, param)
    key = param
    key += "_reverse" if params[:sort] == param
    options = {
        :url => {:action => 'list', :params => params.merge({:sort => key, :page => nil})},
        :update => 'ajax_wrapper',
        :before => "Element.show('spinner')",
        :method => "get",
        :success => "Element.hide('spinner')"
    }
    html_options = {
      :title => "Sort by this field",
      :href => url_for(:action => 'list', :params => params.merge({:sort => key, :page => nil}))
    }
    link_to_remote(text, options, html_options)
  end

  def destination_list_for(day, locale)
    list = day.destinations.with_locale(locale)
    return "none" if list.empty?
    partial_list = list[0..3].collect(&:city).join(', ')
    if list.size > 4
      return "#{partial_list} and more. <b>#{list.size} destinations in total</b>"
    else
      return partial_list
    end
  end

  def tr_line_for(user, att, txt_label=nil)
    txt_label = att.to_s.humanize if txt_label.nil?
    val = user[att] || user.send(att)
    "<tr><td><b>#{txt_label}</b></td><td>#{val}</td></tr>"
  end

  def readiness_group_delta(after, before)
    bgcolor = ""
    bgcolor = "#a9ff9e" if after>before
    bgcolor = "#ff927c" if after<before
    "<td bgcolor='#{bgcolor}'>#{after-before}</td>"
  end
end
