$ ->
  $("#btn_create_goods_exception").one("click", ->
    $("#goods_exception_form").trigger("submit")
  )
  $("#btn_update_goods_exception").one("click", ->
    $("#goods_exception_form").unbind("ajax:before").trigger("submit")
  )
