jQuery ->

  categoryId = null
  if $('.editable').length
    $('.editable').editable
      event: 'click'
      callback: (data) ->

        id = data.$el.data('id')


        content = parseInt(data.content)
        if isNaN(content)
          data.$el.text(0)
        else
          data.$el.text(content)

        sum = 0
        $('.editable[data-id=' + id + ']').each ->
          value = parseInt($(this).text())
          unless isNaN(value)
            sum += value
          
      

        console.log($('.total[data-id=' +  id + ']').text(sum))



  $('.save-product-quantity').on 'click', (evt) ->
    evt.preventDefault()
    $('.live-data').modal('hide')
    $('.total[data-product-id]').each ->
      value = parseInt($(this).text())
      id = ".quantity1.#{$(this).data('id')}"
      unless isNaN(value)
        $(id).val(value)
      $(id).trigger('keyup')

  $('[data-target="#live-data"]').on 'click', ->
    categoryId = $(this).data('id')

    $('.total').each ->
      productId = $(this).data('productId')
      $(this).data('id', "#{categoryId}#{productId}")

    $('td.editable').each ->
      productId = $(this).data('productId')
      $(this).data('id', "#{categoryId}#{productId}")

