# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#is_outter_transit_return').on('click', ->
    if $('#is_outter_transit_return').attr('checked')
      $("select[rel='transit_org_id_yards']").attr('disabled',true)
      $("select[rel='transit_org_id_yards'] option").attr('disable',true)
      $(".outter_transit_to_org_id_with_yards_wrapper").hide()
      $("select[rel='transit_org_id_branches']").attr('disabled',false)
      $("select[rel='transit_org_id_branches'] option").attr('disable',false)
      $(".outter_transit_to_org_id_with_branches_wrapper").show()
    else
      $("select[rel='transit_org_id_yards']").attr('disabled',false)
      $("select[rel='transit_org_id_yards'] option").attr('disable',false)
      $("select[rel='transit_org_id_yards']").show()
      $(".outter_transit_to_org_id_with_yards_wrapper").show()
      $("select[rel='transit_org_id_branches']").attr('disabled',true)
      $("select[rel='transit_org_id_branches'] option").attr('disable',true)
      $(".outter_transit_to_org_id_with_branches_wrapper").hide()
  )
