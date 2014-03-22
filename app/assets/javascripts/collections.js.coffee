# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#list_navigation").change ->
    window.location.hash = this.value

  $(".top-link").click ->
    $("#list_navigation").val("")
