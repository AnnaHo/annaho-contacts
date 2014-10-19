$(document).on 'ready page:load', ->
  $(".btn.btn-mini.btn-danger").click ->
    confirm("Are you sure to delete?")
