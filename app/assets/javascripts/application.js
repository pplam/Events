//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require teams

$(document).on('turbolinks:load', () => {
  const tbs = document.getElementsByTagName('table')
  Array.prototype.forEach.call(tbs, (tb) => {
    tb.className = 'table table-striped table-bordered table-hover'
    const th = tb.querySelector('thead')
    if (th) th.className = 'thead-inverse'
  })
})
