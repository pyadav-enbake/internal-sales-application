// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require ckeditor-jquery
// = require jquery-1.10.2.min.js
// = require underscore
// = require jqueryui-1.10.3.min.js
// = require bootstrap.min.js
// = require bootstrap-collapse.js
// = require enquire.js
// = require jquery.cookie.js
// = require jquery.nicescroll.min.js
// = require plugins/codeprettifier/prettify.js
// = require plugins/easypiechart/jquery.easypiechart.min.js
// = require plugins/sparklines/jquery.sparklines.min.js
// = require plugins/jquery-editable/jquery.editable
// = require plugins/form-toggle/toggle.min.js
// = require plugins/form-inputmask/jquery.inputmask.bundle
// = require plugins/datatables/jquery.dataTables.min.js
// = require plugins/datatables/dataTables.bootstrap.js
// = require demo/demo-datatables.js
// = require plugins/fullcalendar/fullcalendar.min.js
// = require plugins/form-daterangepicker/daterangepicker.min.js
// = require plugins/form-daterangepicker/moment.min.js
// = require plugins/pulsate/jQuery.pulsate.min.js
// = require placeholdr.js
// = require rails.developer
// = require applicationn.js
// = require demo/demo.js
// = require general.js
// = require autocomplete/chosen.jquery.js



function isNumber(evt) {
  var input = String.fromCharCode(evt.keyCode);
  return input.match(/[0-9\.]/);
}

function formSubmit(id)
{
document.getElementById(id).submit();
}

$(function() {

  $('#check_all').change(function(evt) {
    if( $(this).is(":checked") )
      $('.quote-categories').prop('checked', true);
    else
      $('.quote-categories').prop('checked', false);
  });

  $('.mask').inputmask();

});
