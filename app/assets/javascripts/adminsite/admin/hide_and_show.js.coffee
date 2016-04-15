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
  $('form.search').show(200)
  return

Adminsite.hideSearchForm = ->
  $('form.search').hide(200)
  return
