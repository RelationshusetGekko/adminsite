Adminsite.selectedRow = (param) ->
  param_parent = $(param)
  checkbox = param_parent.find('input.collection_selection')
  param_parent.toggleClass 'selected'
  if param_parent.hasClass('selected')
    checkbox.prop 'checked', 'checked'
  else
    checkbox.prop 'checked', null
  return

Adminsite.showSearchForm = ->
  $('.search_form form').show()
  $('.search_form a#show').hide()
  $('.search_form a#hide').show()
  return

Adminsite.hideSearchForm = ->
  $('.search_form form').hide()
  $('.search_form a#show').show()
  $('.search_form a#hide').hide()
  return
