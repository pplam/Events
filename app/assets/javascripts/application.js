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

  const fms = document.getElementsByTagName('form')
  Array.prototype.forEach.call(fms, (fm) => {
    const fds = fm.querySelectorAll('div.field')
    Array.prototype.forEach.call(fds, (fd) => {
      fd.className += ' form-group row'
    })

    const lbs = fm.querySelectorAll('label')
    Array.prototype.forEach.call(lbs, (lb) => {
      lb.className = 'col-sm-1 col-form-label col-form-label-lg'
    })

    const cc = fm.querySelector('#cancel')
    cc.className = 'btn btn-secondary btn-lg button button-outline-gray'
    const sm = fm.querySelector('#submit')
    sm.className = 'btn btn-primary btn-lg button button-outline-blue'
  })
})
