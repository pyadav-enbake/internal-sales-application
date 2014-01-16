
$(document).ready(function() {
  $("#new_customer").on('click',function() {
    $.get("/quote/new_customer",function(data,status){
     $("#formchng").html(data);
    });
  });
 
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
		$('#tprice'+id).val(modify_price);
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
	$( "#extra_info_delivery_date" ).datepicker({dateFormat: 'yy-mm-dd',minDate: 0});	

//send_quote
	$('#send_quote').click(function(){
			if ($("#extra_info_delivery_date").val() == ""){
				$("#err_msg").html('<div class="alert alert-dismissable alert-danger"><button type="button" class="close" data-dismiss="alert">x</button><p>Please select Delivery Date</p></div>');
				return false;
			}else{
				$("#err_msg").html('');
				var frm = $('#send_quote_frm');
				$("#myModal").modal('hide');
				$("#myModalsend").modal({ backdrop: 'static',keyboard: false});
				$.ajax({
					type: frm.attr('method'),
					url: frm.attr('action'),
					data: frm.serialize(),
					success: function (data) {
						$("#myModalsend").modal('hide');
						$('#myModal2').modal({ backdrop: 'static',keyboard: false});
					}
				});
    
			}
		 
	});

//resend_quote

	$(".quantity2").keyup(function(event){
		var id = $(this).attr('id');
		var oprice = $("#oprice"+id).val();
		var text = event.target.value;
		
		var modify_price = (oprice*text).toFixed(2);
		$('#price'+id).text(modify_price);
		$('#tprice'+id).val(modify_price);
		var form = $(this).parents('form')[0];
		var formid = form.id;
		console.log(formid);		
		var total_item_price = total_resend_item_price_count(formid);
		console.log(total_item_price);
		$("#tot_qut_"+formid).text(total_item_price);
	});
	
	//$(".resend_frm input:text").each(function() {
	//	$(this).attr('disabled',true);
//	});			
	$('.edit_quote').click(function(){
		
		var form = $(this).parents('form')[0];
		var formid = form.id;
		$("#"+form.id+" input:text:disabled").each(function() {
			$(this).attr('disabled',false);
		});	
		if ($(this).val() == 'Edit'){
			$(this).val('Resend Quote');
			$(this).attr('type','submit');
			return false;	
		}

	});


	function total_resend_item_price_count(formid){
		var total_price = 0.00;
		//$('#'+formid+' span[id^="price"]').each(function(index) {
			//this.id = "id_" + (index + 1);
			//console.log(this.val()+'kkkkkkk');	
		//});
		$('#'+formid+' span[id^="price"]').map(function() {
			//console.log($(this).text()+'kkkkkkk');
			total_price += Number($(this).text());
		})			

	total_price = total_price.toFixed(2);
		return total_price
	}

		

});

function check_product(){
	var totp = $("#total_price").text();
	if(parseInt(totp) == 0){
		//$("#myModal1").modal({ backdrop: 'static',keyboard: false});
		$('#myModal1').modal('show');
		return false;
	}else{
		$('#myModal').modal('show');
		return true;
	}
}

function get_customer(id){
   $.ajax({
    url: "/quote/get_customer",
    type: "POST",
    data: {"contractor_id" : id},
    success: function(data) {
      $("#part_cust").html(data);
    }
  });
}
