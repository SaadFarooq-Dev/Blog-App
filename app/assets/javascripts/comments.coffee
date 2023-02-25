# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('turbolinks:load', ->
  $(document).ready ->
    document.querySelectorAll('.comment-form-display').forEach((el) ->
      el.addEventListener('click', (ev) ->
        ev.preventDefault()
        el.nextElementSibling.style = 'display:block'
  ))

  $(document).ready ->
    document.querySelectorAll('.comment-report-display').forEach((el) ->
      el.addEventListener('click', (ev) ->
        ev.preventDefault()
        el.nextElementSibling.style = 'display:block'
))
)


$(document).on('turbolinks:load', ->
  $(document).ajaxComplete ->
    document.querySelectorAll('.comment-form-display').forEach((el) ->
      el.addEventListener('click', (ev) ->
        ev.preventDefault()
        el.nextElementSibling.style = 'display:block'
  ))

  $(document).ajaxComplete ->
    document.querySelectorAll('.comment-report-display').forEach((el) ->
      el.addEventListener('click', (ev) ->
        ev.preventDefault()
        el.nextElementSibling.style = 'display:block'
))
)


