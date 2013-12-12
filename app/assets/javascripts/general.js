
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
   
   
	$("#rcadmin_product_category_id").change(function() {
	  $.ajax({
		url: "/rcadmin/subcat",
		type: "get",
		data: {cat_id:$(this).val()},
		success: function( data ){
				$("#scat").addClass('form-group');
				$("#scat").html(data);
		}
	 });
   }); 



  $( "#accordion" ).accordion();
  $( ".accordion" ).accordion();

	$( "#subtabs" ).tabs();

//fAQ
	$('.showSingle').click(function(){
		  $('.targetDiv').hide();
		  $('#div'+$(this).attr('target')).show();
	});
	
//Quote Calculation
	$(".quantity1").keyup(function(event){
		var id = $(this).attr('id');
		var oprice = $("#oprice"+id).val();
		var text = event.target.value;
		
		var modify_price = (oprice*text).toFixed(2);
		$('#price'+id).text(modify_price);
		var total_item_price = total_item_price_count();
		$("#total_price").text(total_item_price);
	});
	$(".chkpro").click(function(event){
		var id = $(this).attr('id').replace('chk','');
		if($("#chk"+id).is(':checked')){
			var total_item_price = total_item_price_count();
			$("#total_price").text(total_item_price);
		}else{
			var total_item_price = total_item_price_count();
			$("#total_price").text(total_item_price);
		}
	})	
	
	function total_item_price_count(){
		var total_price = 0.00;
		$("#tabs input:checkbox:checked").each(function() {
			var id = $(this).attr('id').replace('chk','');
			var price = $('#price'+id).text();
			total_price += Number(price);
			
		});
		total_price = total_price.toFixed(2);
		return total_price
	}	

});


