$ ->
  $("#btn_generate_load_list_for_load_in").on("click", ->
    $("#state_eq").remove()
    $(this).after($("<input type='hidden' id='state_eq' value='loaded_in' />"))
  )
  $("#btn_generate_load_list").on("click", ->
    $("#state_eq").remove()
    $(this).after($("<input type='hidden' id='state_eq' value='billed' />"))
  )

  $("#btn_generate_load_list_for_short_list_reached").on("click", ->
    $("#state_eq").remove()
    $(this).after($("<input type='hidden' id='state_eq' value='short_list_reached' />"))
  )
