jQuery(document).on 'page:change', ->
  close_btns = $('body.adminsite #applied_filters button').on "click", ->
      btn = jQuery(this)
      op = btn.attr('data-filter-op')
      value = btn.attr('data-filter-value')
      column = btn.attr('data-filter-column')
      search_pattern = '&q[' + column + '_' + op + ']=' + value
      # console.log(column, op, value, search_pattern)
      current_url = decodeURIComponent(window.location.search)
      next_url = current_url.replace(search_pattern, '')
      window.location.search = next_url
      return
  return
