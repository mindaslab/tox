# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  myVar = setInterval(->
    update_messages()
  , 3000)

  $("#transmit").click ->
    message_content = $("#message_content").val()
    $.ajax
      type: "POST"
      url: "/receiver/create_message"
      data: {txt: message_content}
      success: $("#message_content").val("")


update_messages = ->
  $.get "/receiver/update", (data) ->
    $("#messages").prepend(data)
