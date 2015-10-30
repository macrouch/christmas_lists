# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  clip = new ZeroClipboard($(".clipboard-button"))

  $(".group-join-link").tooltip()

  $(document).on 'click', '.group-invite-link', ->
    groupId = $(this).data('id')
    $("#invite-modal #group_id").val(groupId)

  makeSortable = (element) ->
    $(element).sortable(
      connectWith: 'ul'
      receive: (event, ui) ->
        $newEle = undefined
        if $(this).is('.empty')
          id = parseInt($(this).attr('id').split('-')[1])
          $newEle = $(this).parent().clone()
          $newEle.find('ul').attr('id', "sortable-#{id + 1}")
          $newEle.insertAfter($(this).parent()).find('ul').empty()
          $(this).removeClass 'empty'
          makeSortable $newEle.find('ul')

        $('.sub-group').not('.sub-group.default-group').each (index, element) ->
          $(this).find('h5').text("Group #{index + 1}")

        $('.sub-group').last().find('h5').text("New Group")

      remove: (event, ui) ->
        # remove stack if empty
        if $(this).attr('id') != 'sortable-1' and !$(this).children('li').length
          $(this).parent().remove()
    ).disableSelection()

  $('ul.sortable').each ->
    makeSortable this

  $('#save-sub-groups-form').on 'click', 'input[type="submit"]', ->
    $form = $(this)
    # setup hidden fields with groups and member ids
    $('.sub-group').not('.sub-group.default-group').each (index, group) ->
      $(group).find('li').each (index2, member) ->
        memberId = $(member).data('member-id')
        $('<input />',
          type: 'hidden'
          name: "sub_groups[#{index}][]"
          value: memberId
        ).appendTo($form)
        console.log 'stuff here!'
