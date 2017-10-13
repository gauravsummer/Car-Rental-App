# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
#$(document).on 'ready page:load', -> $(this).datepicker({ minDate: 0, maxDate: "+1Y", dateFormat: 'yy-mm-dd'});
$(document).on "focus", "[data-behaviour~='datepicker']", (e) ->
  - $(this).datepicker
  - format: "dd-mm-yyyy"
  - weekStart: 1
  - autoclose: true

#$(document).on 'ready page:load', -> $(this).datepicker({ minDate: 0, maxDate: "+1Y", dateFormat: 'yy-mm-dd'});