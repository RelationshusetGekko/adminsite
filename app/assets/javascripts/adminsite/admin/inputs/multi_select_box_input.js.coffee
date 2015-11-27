class window.Adminsite.Inputs

Adminsite.Inputs.prepareMultiSelectBoxSubmit = ->
  form = $(this)
  deselectAllOptions form.find('select.source')
  selectAllOptions form.find('select.target')
  return

Adminsite.Inputs.addToTarget = (wrapper_id) ->
  wrapper = $(wrapper_id)
  source = wrapper.find('select.source')
  target = wrapper.find('select.target')
  SelectMoveRows(source, target)
  return

Adminsite.Inputs.removeFromTarget = (wrapper_id) ->
  wrapper = $(wrapper_id)
  source = wrapper.find('select.source')
  target = wrapper.find('select.target')
  SelectMoveRows(target, source)
  return

Adminsite.Inputs.moveUp = (select_id) ->
  select = $(select_id)
  $op = select.find('option:selected')
  $op.first().prev().before($op) if $op.length
  return

Adminsite.Inputs.moveDown = (select_id) ->
  select = $(select_id)
  $op = select.find('option:selected')
  $op.last().next().after($op) if $op.length
  return

deselectAllOptions = (select) ->
  select.find('option').prop('selected', false);
  return

selectAllOptions = (select) ->
  select.find('option').prop('selected', true);
  return

SelectMoveRows = (source, target) ->
  $op = source.find('option:selected')
  target.append($op)
  return

Adminsite.Inputs.initInputs =  ->
  $('form').on('submit', Adminsite.Inputs.prepareMultiSelectBoxSubmit)
  return

$(document).on('page:change', Adminsite.Inputs.initInputs)

