$(document).ready(function() {
	$("#dimension_category_type").change(function() {
	  $.ajax({
		url: "/rcadmin/catdimen_name",
		type: "get",
		data: {val:$(this).val()},
		success: function( data ){
				$("#ctype").addClass('form-group');
				$("#ctype").html(data);
		}
	 });
   });

	$("#dimensionn_category_type").change(function() {
	  $.ajax({
		url: "/rcadmin/dc_name",
		type: "get",
		data: {val:$(this).val()},
		success: function( data ){
				$("#dc").addClass('form-group');
				$("#dc").html(data);
		}
	 });
   });

//fAQ
	$('.showSingle').click(function(){
		  $('.targetDiv').hide();
		  $('#div'+$(this).attr('target')).show();
	});

});
