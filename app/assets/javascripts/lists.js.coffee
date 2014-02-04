# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#list_name").focus()

  $(".icon-exclamation-sign").tooltip({
    title: 'Item hidden from owner'
  })

  $(".icon-check").tooltip({
    title: 'Item has been purchased'
  })
