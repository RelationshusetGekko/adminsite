class Adminsite::MultiSelectBoxInput < Formtastic::Inputs::SelectInput
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  def to_html
    # super
    puts "this is my own version of Adminsite::MultiSelectBoxInput"
    diff_collection = collection.reject{|k,v| builder.object.send(input_name).include?(k) }
    input_wrapping do
      label_html <<
      raw("<div><span>Available #{(localized_label || humanized_method_name)}:</span><br/>") <<
      select_tag(:collection, options_for_select(diff_collection), input_html_options.merge(:class => 'source', :name=> "#{object_name}[collection][]", :id=> collection_id)) <<
      raw('</div>') <<
      operators_html <<
      raw("<div><span>Selected #{label_text}:</span><br/>") <<
      builder.select(input_name, builder.object.send(input_name), input_options, input_html_options.merge(:class => 'target') ) <<
      raw('</div>')
    end.html_safe
  end

  def operators_html
    raw('<div class="operators"><div class="data-ops">') <<
    button_tag('Add',    type: 'button', onClick: "Adminsite.Inputs.addToTarget('##{wrapper_dom_id}'); false;" ) <<
    button_tag('Remove', type: 'button', onClick: "Adminsite.Inputs.removeFromTarget('##{wrapper_dom_id}'); false;" ) <<
    raw('</div><div class="order-ops">') <<
    button_tag('&#8679;'.html_safe, type: 'button', onClick: "Adminsite.Inputs.moveUp('##{dom_id}'); false;" ) <<
    button_tag('&#8681;'.html_safe, type: 'button', onClick: "Adminsite.Inputs.moveDown('##{dom_id}'); false;" ) <<
    raw('</div></div>')
  end

  def collection_id
    @collection_id ||= "#{object_name}_collection"
  end

  def multiple?
    true
  end
end
