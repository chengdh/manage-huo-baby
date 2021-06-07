# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#bill_note_form").on('submit', ->
    note = $("#bill_note_form #bill_note_note").val()
    if note = !! note
      $.notifyBar(
        html: "请运单备注信息!",
        delay: 2000,
        animationSpeed: "normal",
        cls: 'error'
      )
      return false
  )
