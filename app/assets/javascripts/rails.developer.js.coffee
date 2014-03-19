jQuery ->

  quoteMiscs = ->
    fieldName = $('.misc-field-name').val()
    if fieldName.length
      console.log(fieldName)
      dbName = fieldName.replace(/[^a-zA-Z0-9\-_]+/g, '-').replace(/(^-|-$)/g, '').replace(/-/g, '_').toLowerCase()
      $div = $('<div />', {class: 'row'})
      $label = $('<label />', {for: fieldName, text: fieldName, class: 'col-sm-3 control-label'})
      $input = $('<input />', {type: 'text', value: '', name: 'misc[' + dbName+ ']', class: 'form-control'})
      $inputWrapper = $('<div />', {class: 'col-sm-6'})
      $inputWrapper.append($input)
      $div.append($label)
      $div.append($inputWrapper)

      $('.misc-fields').append($div)
      $('.misc-fields').append('<br />')
      $('.misc-field-name').val('')
      $('.misc-field-name').focus()


  $('.create-field').on 'click', (evt) ->
    evt.preventDefault()
    quoteMiscs()

  $('.misc-field-name').on 'keypress', (evt) ->
    if evt.which == 13
      evt.preventDefault()
      quoteMiscs()



  $('#page-content').on 'click', '.option-product', (evt) ->
    hideProduct = $(this).closest('.quote-product').find('.hide-product')
    if hideProduct.length and hideProduct.is(":checked")
      evt.preventDefault()
      alert("You can not hide options")

  $('#page-content').on 'click', '.hide-product', (evt) ->
    optionProduct = $(this).closest('.quote-product').find('.option-product')
    if optionProduct.length and optionProduct.is(":checked")
      evt.preventDefault()
      alert("You can not hide options")

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
