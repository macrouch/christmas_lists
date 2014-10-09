# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#item_name").focus()

  $(".fa-question-circle").tooltip()

  $(".btn-file :file").on "fileselect", (event, label) ->
    input = $(this).parents(".input-group").find(":text")
    input.val label


$(document).on "change", ".btn-file :file", ->
  input = $(this)
  label = input.val().replace(/\\/g, "/").replace(/.*\//, "")
  input.trigger "fileselect", label


$(document).on "click", "span.toggle-image", ->
  if $(this).text() == "Need to use a URL instead?"
    $(this).text("Need to choose an image on your device?")
    $(".image-browse").prop('disabled', true)
    $(".image-url").prop('disabled', false)
  else
    $(this).text("Need to use a URL instead?")
    $(".image-browse").prop('disabled', false)
    $(".image-url").prop('disabled', true)

  $(this).parents(".form-group").find(".input-group,.image-url,.toggle-image-label").toggleClass("hidden")
