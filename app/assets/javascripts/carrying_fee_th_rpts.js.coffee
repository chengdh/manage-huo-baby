# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  change_query_url = ->
    mth = $('#search_mth').val()
    year = $('#search_year').val()
    ori_href = $('.btn_query_carrying_fee_th_rpt').data('href')
    href = ori_href + "&" + "search[year]=#{year}&search[mth]=#{mth}"

    $('.btn_query_carrying_fee_th_rpt').attr('href',href)


  $('#search_year,#search_mth').on("change",change_query_url)
