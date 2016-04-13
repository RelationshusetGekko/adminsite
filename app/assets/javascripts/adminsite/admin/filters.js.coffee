jQuery(document).on 'page:change', ->
  close_btns = jQuery('body.adminsite #applied_filters button')
  close_btns.each ->
    btn = jQuery(this)
    btn.click btn.attr('data-filter'), (filter) ->
      current_url = decodeURIComponent(window.location.search)
      next_url = current_url.replace(new RegExp(filter.data), '')
      console.log(current_url)
      console.log(filter.data)
      console.log(next_url)
      alert('Please check the console.')
      window.location.search = next_url
      return
    return
  return
