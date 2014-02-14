jQuery ->

  categoryId = null
  if $('.editable').length
    $('.editable').editable
      event: 'click'
      callback: (data) ->

        id = data.$el.attr('klass')


        content = parseInt(data.content)
        if isNaN(content)
          data.$el.text(0)
        else
          data.$el.text(content)

        sum = 0
        $('.editable[klass=' + id + ']').each ->
          value = parseInt($(this).text())
          unless isNaN(value)
            sum += value
          
      

        console.log($('.total[klass=' +  id + ']').text(sum))



  $('.save-product-quantity').on 'click', (evt) ->
    evt.preventDefault()
    $('.live-data').modal('hide')
    $('.total[data-product-id]').each ->
      value = parseInt($(this).text())
      id = ".quantity1.#{$(this).attr('klass')}"
      unless isNaN(value)
        $(id).val(value)
      $(id).trigger('keyup')

  $('[data-target="#live-data"]').on 'click', ->
    categoryId = $(this).data('id')

    $('td.total').each ->
      productId = $(this).data('productId')
      $(this).attr('id', "#{categoryId}#{productId}")
      $(this).removeAttr('klass')
      $(this).attr('klass', "#{categoryId}#{productId}")

    $('td.editable').each ->
      productId = $(this).data('productId')
      $(this).removeAttr('klass')
      $(this).data('id', "#{categoryId}#{productId}")
      $(this).attr('klass', "#{categoryId}#{productId}")
