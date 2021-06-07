# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $("#adjust_carrying_fee_search_box").val() != ""
    $("#adjust_carrying_fee_search_box").trigger(jQuery.Event('keypress', { keyCode: 13 }))
