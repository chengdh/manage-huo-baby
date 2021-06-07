# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".btn_save_progress").one("click",->
    $("#task_form").submit()
  )

  $(".btn_save_finish").one("click",->
    $("#task_form").submit()
  )
