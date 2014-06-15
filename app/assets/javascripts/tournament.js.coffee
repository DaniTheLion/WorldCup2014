# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".user-rank td").hover \
    ((r)->
      # url = $(this).attr("data-large")
      # $("#large").css("bottom",($(window).height() - e.pageY)+"px") \
      # .css("right", ($(window).width() - e.pageX)+"px") \
      # .html("<img src='" + url + "' alt='Large Image' /><br/>") \
      # .fadeIn("slow") if url),
      console.log($.attr(this,'id'))
      $(this).find('.user-bet').show('slow');
      $(this).find('.user-bet').attr('display','block');


      ),
    (-> $(this).find('.user-bet').hide("fast"))
