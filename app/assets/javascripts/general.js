
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



 // $( "#accordion" ).accordion();
  //$( ".accordion" ).accordion({ collapsible: true });
  $( "#subtabs" ).tabs();

//fAQ
  $('.showSingle').click(function(){
    $('.targetDiv').hide();
    $('#div'+$(this).attr('target')).show();
  });


  (function() {

    // Handles all calculation logic in view and for form

    var products = {}; 

    $('#subtabs').on('keyup', '.quantity', function(evt) {
      var quantity = parseInt($(this).val(), 10);
      var id = $(this).attr('id');
      var $parent = $(this).closest('tr');

      if(isNaN(quantity)) {

        delete products[id];
        $parent.find('.total-price-text').text('0.00');
        $parent.find('.total-price-field').val('0.00');
      } else {

        var price = Number($parent.find('.price').text());
        products[id] = price * quantity;

        var totalProductPrice = products[id].toFixed(2);
        $parent.find('.total-price-text').text(totalProductPrice);
        $parent.find('.total-price-field').val(totalProductPrice);
      }
      var totalPrice = productsSum().toFixed(2)
      $('#total_price').text(totalPrice);
    });


    // Using colsure to bring in products object (which is productId with total cose)
    productsSum = function() {
      var sum = 0.0;
      for(var key in products) {
        sum += products[key];
      }
      return sum;
    };

    window.total_price_calculator = productsSum;
    window.QuoteCalculator = QuoteCalculator;


    function QuoteCalculator() {

      this.cabinetTotal = function() {
        return productsSum();
      };

      this.laminateTopTotal = function() {
        return 0.0;
      };

      this.productTotal = function() {
        return this.cabinetTotal() + this.laminateTopTotal();
      };

      this.percentage = function() {
        return Number($('.quote-percentage').text()) || 59;
      };

      this.percentageValue = function() {
        return ( this.productTotal() / 100 * this.percentage() );
      };

      this.factor = function() {
        return ( Number( $('.quote-factor').text() ) || 1.2 );
      };

      this.factorValue = function() {
        return ( ( this.percentageValue() * this.factor() ) - ( this.taxValue() + this.delivery() ) )
      };

      this.preTax = function() {
        return ( this.percentageValue() + this.factor() + this.corian() + this.miscs() );
      };

      this.taxPercentage = function() {
        return ( ( parseFloat( $('.quote-tax-percentage').text() ) * 1.0 ) || 1);
      };

      this.taxValue = function() {
        return ( this.preTax() / 100 * this.taxPercentage() );
      };

      this.subTotal = function() {
        return ( this.preTax() + this.taxValue() );
      };

      this.labor = function() {
        return ( ( parseFloat( $('.labor-total').val() ) * 1.0) || 0.0 );
      };

      this.delivery = function() {
        return ( ( this.subTotal() / 5000.0 + 1 ) * 75 );
      };

      this.corian = function() {
        return ( parseFloat( $('.corian-total').val() ) * 1.0 );
      };

      this.grandTotal = function() {
        return ( this.subTotal() + this.delivery() + this.labor() );
      };

      this.miscs = function() {
        return ( ( parseFloat( $('.misc-total').text() ) * 1.0) || 0.0);
      };

      this.updateDOM = function() {
        $('.cabinet-total').text( this.cabinetTotal().toFixed(2) );
        $('.laminate-top-total').text( this.laminateTopTotal().toFixed(2) );
        $('.product-total').text( this.productTotal().toFixed(2) );
        $('.percentage-total').text( this.percentageValue().toFixed(2) );
        $('.factor-total').text( this.factorValue().toFixed(2) );
        $('.cabinet-total').text( this.cabinetTotal().toFixed(2) );
        // $('.corian-total').val( this.corian() );
        $('.pre-tax-total').text( this.preTax().toFixed(2) );
        $('.tax-total').text( this.taxValue().toFixed(2) );
        $('.subtotal-total').text( this.subTotal().toFixed(2) );
        // $('.labor-total').val( this.labor() );
        $('.delivery-total').text( this.delivery().toFixed(2) );
        $('.grand-total').text( this.grandTotal().toFixed(2) );
      };

    } // class QuoteCalulator ends



    var quote = new QuoteCalculator();
    $('.corian-total, .labor-total').keyup(function(evt) {
      $(this).trigger('change');
    });

    $('.corian-total, .labor-total').change(function(evt) {
      quote.updateDOM();
    });

  })();
  

  $( "#quote_delivery_date" ).datepicker({dateFormat: 'yy-mm-dd',minDate: 0});

//send_quote
  $('#send_quote').click(function(){
    if ($("#quote_delivery_date").val() == ""){
      $("#err_msg").html('<div class="alert alert-dismissable alert-danger"><button type="button" class="close" data-dismiss="alert">x</button><p>Please select Delivery Date</p></div>');
      return false;
    }else{
      $("#myModal").modal('hide');
      $("#myModalconfirmsend").modal({ backdrop: 'static',keyboard: false});
    }

  });

//Confirm and send Quote

  $('#confirm_send_quote').click(function(){
    $("#err_msg").html('');
    var frm = $('#send_quote_frm');
    //console.log(frm.attr('action'));return false;
    $("#myModalconfirmsend").modal('hide');
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
  });

  $('button[data-dismiss=modal]').click(function(evt) {
    evt.preventDefault();
    $('.quote-preview').html('');
  });


  $('#save-draft').click(function() {
    var previewForm = $('#send_quote_frm');
    previewForm.attr('action', 'quote_preview?draft=true')
    previewForm.submit();
  });

  $('#preview_quote').click(function(){
    $("#err_msg").html('');
    var previewForm = $('#send_quote_frm');
    $.post('quote_preview', previewForm.serialize()).success(function(data) {
      $('.quote-preview').html(data);
    });
    // preview_frm.attr('target','_blank');
    // preview_frm.attr('action','quote_preview').submit();
    previewForm.attr('action','send_quote');
    //console.log(frm.attr('action'));return false;
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
  //Expand and collaps

  $(".accordion" ).accordion({ collapsible: true ,heightStyle: "fill"});

  $('.expand').click(function() {
      var inhtml = $('.expand').html();
      if(inhtml == 'Expand All'){
          $('.expand').html('Collapse All');
          $('#accordion .ui-widget-content').fadeIn(1000);
      }else{

          $('.expand').html('Expand All');
          $('#accordion .ui-widget-content').fadeOut(1000);
          $(".accordion" ).accordion( "option", "active",-90);

      }

      //$('#accordion .ui-widget-content').toggle('slow');
  });


  //Add Room

  $('#add_new_room_modal').click(function(){
      $("#err_msg_room").html('');
      $("#myModaladdroom").modal('show');
  });

  $('#add_room').click(function(){
      $("#err_msg_room").html('');
      if($("#room_name").val() == ""){
          $("#err_msg_room").html('<div class="alert alert-dismissable alert-danger"><button type="button" class="close" data-dismiss="alert">x</button><p>Please put room name</p></div>');
          return false;
      }
      var frm  = $("#new_rcadmin_category");
      $.ajax({
          type: frm.attr('method'),
          url: frm.attr('action'),
          data: frm.serialize(),
          success: function (data) {
              $("#all_cat" ).css( "class",'' );
              $("#all_cat" ).addClass( "form-group" );
              $("#all_cat").html(data);
              $("#myModaladdroom").modal('hide');
          },
          error: function (xhr, ajaxOptions, thrownError,status) {
              $("#err_msg_room").html('<div class="alert alert-dismissable alert-danger"><button type="button" class="close" data-dismiss="alert">x</button><p>Category name already exist</p></div>');
              return false;
          }
      });

  });

});

function total_resend_item_price_count(formid){
    var total_price = 0.00;
    $('#'+formid+' span[id^="price"]').map(function() {
        //console.log($(this).text()+'kkkkkkk');
        total_price += Number($(this).text());
    })

    total_price = total_price.toFixed(2);
    return total_price
}

function check_product(){
    var totp = $("#total_price").text();

    var quote = new QuoteCalculator();
    quote.updateDOM();
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
