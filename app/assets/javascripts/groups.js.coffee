# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  clip = new ZeroClipboard($(".clipboard-button"))

  $(".group-join-link").tooltip()

  $(document).on 'click', '.group-invite-link', ->
    groupId = $(this).data('id')
    $("#invite-modal #group_id").val(groupId)
