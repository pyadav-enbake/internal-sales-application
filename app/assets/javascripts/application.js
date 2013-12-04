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
// = require jqueryui-1.10.3.min.js
// = require bootstrap.min.js
// = require bootstrap-collapse.js
// = require enquire.js
// = require jquery.cookie.js
// = require jquery.nicescroll.min.js
// = require plugins/codeprettifier/prettify.js
// = require plugins/easypiechart/jquery.easypiechart.min.js
// = require plugins/sparklines/jquery.sparklines.min.js
// = require plugins/form-toggle/toggle.min.js
// = require plugins/datatables/jquery.dataTables.min.js
// = require plugins/datatables/dataTables.bootstrap.js
// = require demo/demo-datatables.js
// = require plugins/fullcalendar/fullcalendar.min.js
// = require plugins/form-daterangepicker/daterangepicker.min.js
// = require plugins/form-daterangepicker/moment.min.js
// = require plugins/pulsate/jQuery.pulsate.min.js
// = require placeholdr.js
// = require applicationn.js
// = require demo/demo.js
// = require general.js


$(document).ready(function() {
$('.quantity').click(function() {
	var id = $(this).attr('id');
	var oprice = $("#oprice"+id).val();
	console.log(oprice);
	var text = $(this).text();
	var input = $('<input id="attribute" onkeypress="return isNumber(event)" value="' + text + '" />')
	$(this).text('').append(input);
	input.select();
	
	
	input.blur(function() {
		var text = $('#attribute').val();
		var modify_price = (oprice*text).toFixed(2);
		$('#price'+id).text(modify_price);
		$('#cprice'+id).val(modify_price);
		$('#cq'+id).val(text);
		$('#attribute').parent().text(text);
		$('#attribute').remove();
	});
});	

});

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function formSubmit(id)
{
document.getElementById(id).submit();
}
