jQuery ->


  $('.show-misc-modal').on 'click', (evt) ->
    evt.preventDefault()
    evt.stopPropagation()
    $('#new-misc-product-modal').modal('show')


  do ->

    $form = $('form.new-misc-product')

    $form.on 'submit', (evt) ->
      evt.preventDefault()
      evt.stopPropagation()
      createMiscProduct()

    $form.find('button[type=submit]').on 'click', (evt) ->
      evt.preventDefault()
      evt.stopPropagation()
      createMiscProduct()

    createMiscProduct = ->
      data = $form.serializeArray()
      url = $form.attr('action')
      $.post(url, data, null, 'script')

  miscsInputs = {}
  miscsSum = ->
    sum = 0
    for name, value of miscsInputs
      sum += value
    sum

  quoteMiscs = ->
    fieldName = $('.misc-field-name').val()
    if fieldName.length
      console.log(fieldName)
      dbName = fieldName.replace(/[^a-zA-Z0-9\-_]+/g, '-').replace(/(^-|-$)/g, '').replace(/-/g, '_').toLowerCase()
      $div = $('<tr />')
      $label = $('<td />', {text: fieldName})

      $td = $('<td />')
      $input = $('<input />', {type: 'text', value: '', name: 'quote[miscs][' + dbName+ ']', class: 'form-control'})
      $td.append($input)

      $div.append($label)
      $div.append($td)

      $input.on 'keyup', (evt) ->
        miscsInputs[$(this).attr('name')] = Number($(this).val())
        $('.misc-total').text(miscsSum())
        new QuoteCalculator().updateDOM()


      $('.misc-td').after($div)
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
    hideProduct = $(this).closest('tr').find('.hide-product')
    if hideProduct.length and hideProduct.is(":checked")
      evt.preventDefault()
      alert("You can not hide options")

  $('#page-content').on 'click', '.hide-product', (evt) ->
    optionProduct = $(this).closest('tr').find('.option-product')
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
