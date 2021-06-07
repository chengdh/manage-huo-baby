# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  func_save_vote =  (url,must_check_all)->
    vote_item_size= $("span.vote_item").length
    if must_check_all and $(":radio:checked").length < vote_item_size
      notify_object = 
        html: "请全部打分!",
        delay: 3000,
        animationSpeed: "normal",
        cls: 'error'

      $.notifyBar(notify_object)
      return false

    vote_items = []
    vote_rates = []
    if $('.vote-weight').length
      for r in $(".vote-weight")
        vote_item_id = $(r).data("vote_item_id")
        vote_rate = $(r).val()
        vote_items.push(parseInt(vote_item_id))
        vote_rates.push(parseInt(vote_rate))
    else
      for r in $(":radio:checked")
        vote_item_id = $(r).attr("name")
        vote_rate = $(r).val()
        vote_items.push(parseInt(vote_item_id))
        vote_rates.push(parseInt(vote_rate))

    data =
      "vote_scope" : $("#vote_scope").val(),
      "vote_items[]" : vote_items,
      "vote_rates[]" : vote_rates

    $.post("/#{url}/save_vote",data,null,'script')

  $(".btn-vote-confirm").on('click',-> func_save_vote("vote_configs",true))
  $(".btn-vote-config-with-org-confirm").on('click',-> func_save_vote("vote_config_with_orgs",true))
  $(".btn-single-vote-config-with-org-confirm").on('click',-> func_save_vote("single_vote_config_with_orgs",false))

  #单选处理
  $(".radio-single-vote").on("change",->
    that = this
    checked = $(this).prop("checked")
    $(".radio-single-vote").prop("checked",false)
    $(that).prop("checked",true)
  )
