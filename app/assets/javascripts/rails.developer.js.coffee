jQuery ->
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
        

      $('.total.' + data.$el.data('id')).text(sum)



  $('.save-product-quantity').on 'click', (evt) ->
    evt.preventDefault()
    $('.live-data').modal('hide')
    $('.total[data-product-id]').each ->
      value = parseInt($(this).text())
      id = ".quantity1." + $(this).data('productId')
      unless isNaN(value)
        $(id).val(value)
      $(id).trigger('keyup')
