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
    const fds = fm.querySelectorAll('.ffield')
    Array.prototype.forEach.call(fds, (fd) => {
      fd.className = 'field form-group row'
    })

    const lbs = fm.querySelectorAll('.flabel')
    Array.prototype.forEach.call(lbs, (lb) => {
      lb.className = 'col-sm-2 col-form-label col-form-label-lg'
    })

    const cts = fm.querySelectorAll('.fcontrol')
    Array.prototype.forEach.call(cts, (ct) => {
      ct.className = 'form-control form-control-lg'
    })

    const cc = fm.querySelector('#cancel')
    if (cc) cc.className = 'btn btn-secondary btn-lg button button-outline-gray'
    const sm = fm.querySelector('#submit')
    if (sm) sm.className = 'btn btn-primary btn-lg button button-outline-blue'
  })
})
