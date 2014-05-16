jQuery ->


  $('.rooms').on('keyup', '.factor-total, .corian-total, .labor-total', (evt) ->
    evt.preventDefault()
    $ancestor = $(this).closest('.quote-categories')
    categoryName = $ancestor.data('categoryClass')
    room = new RoomCalculator(".#{categoryName.trim()}")
    room.updateView()
  )

  categoriesMiscsSum = (object) ->
    sum = 0
    for name, value of object
      sum += value
    sum

  categoryMisc = ($element, miscsInputs) ->
    fieldName = $element.find('.misc-field-name').val()
    if fieldName.length
      hidden_field = $element.find('.factor-total').attr('name')
      dbName = fieldName.replace(/[^a-zA-Z0-9\-_]+/g, '-').replace(/(^-|-$)/g, '').replace(/-/g, '_').toLowerCase()
      $div = $('<tr />')
      $label = $('<td />', {text: fieldName})

      $td = $('<td />')
      $input = $('<input />', {type: 'text', value: '', name: hidden_field.replace('factor', dbName), class: 'form-control'})
      $td.append($input)

      $div.append($label)
      $div.append($td)

      $input.on 'keyup', (evt) ->
        miscsInputs[$(this).attr('name')] = Number($(this).val())
        $element.find('.misc-total').text(categoriesMiscsSum(miscsInputs))
        new RoomCalculator("."+$element.data('categoryClass').trim()).updateView()


      $element.find('.misc-td').after($div)
      $element.find('.misc-field-name').val('')
      $element.find('.misc-field-name').focus()


  categoriesMiscTotal = {}

  $('.rooms').on('click', '.create-field', (evt) ->
    evt.preventDefault()
    $ancestor = $(this).closest('.quote-categories')
    categoryName = $ancestor.data('categoryClass').trim()

    $element = $(".#{categoryName}")
    unless _.isObject(categoriesMiscTotal[categoryName] )
      categoriesMiscTotal[categoryName] = {}

    categoryMisc($element, categoriesMiscTotal[categoryName])

  )

  # Print logic goes here 

  $(document).on('click', '.add-page', (evt) ->
    evt.preventDefault()
    $.getScript(window.location.href)
  )

  $(document).on('change', '.page-cabinet', (evt) ->
    $this = $(this)
    $.get(window.location.href, {category_id: $(this).val()}).success( (html) ->
      $this.closest('.page').html(html)
    )
  )

  $(document).on('change', '.page-categories', (evt) ->
    $this = $(this)
    $.get(window.location.href, $this.closest('form').serialize()).success( (html) ->
      $this.closest('.page').html(html)
    )
  )

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  })

  $('.quote-status').on 'change', (evt) ->
    data = { quote: { status: $(this).val() } }
    $.ajax({
      method: 'PATCH',
      data: data,
      url: $(this).data('url'),
      dataType: 'script'
    })

  $('.selection-select').on 'change', (evt) ->
    selectionValue = $(this).find('option:selected').text()

    if selectionValue == 'Other'
      fieldName = $(this).attr('name')
      fieldName = fieldName.replace('selection_type_id', 'name')
      $inputField = $('<input />', {name: fieldName, class: 'other-field-name form-control'})
      unless $(this).siblings('.other-field-name').length
        $(this).after($inputField)

  $(document).on('click', '.search-products-btn', (evt) ->
    evt.preventDefault()
    searchText = $('.search-products-text').val().trim()
    regex = new RegExp(searchText, 'i')
    matches = new Object()

    # Clear old search changes and unexpand accordions
    $('#accordion .ui-widget-content').hide()
    $('.ui-accordion-content .table tr').removeAttr('style')
    
    # Search each title for search term and highligh it
    $('.ui-accordion-content .table .title').each (index) ->
      title = $(this).text().trim()
      if regex.test title
        id = $(this).closest('.ui-accordion-content').attr('id')
        matches[id] = "##{id}"
        $(this).parent().css({'background-color': 'yellow'})




    selectorArray = _.values(matches)

    navigation = ->

      $(".search-controls").show()

      if selectorArray.length
        $(window).scrollTop $(selectorArray[0]).offset().top - 80

      current = 0
      $('.search-next').click (evt) ->
        evt.preventDefault()
        if current < ( selectorArray.length - 1 )
          $(window).scrollTop $(selectorArray[++current]).offset().top - 80

      $('.search-prev').click (evt) ->
        evt.preventDefault()
        if current > 0
          $(window).scrollTop $(selectorArray[--current]).offset().top - 80

      $('.search-cancel').click (evt) ->
        evt.preventDefault()
        $(".search-controls").hide()
        $('.search-products-text').val("")
        $('#accordion .ui-widget-content').hide()
        $(window).scrollTop $('.search-products-text').offset().top - 100
        

    selector = selectorArray.join(", ")
    $(selector).show()
    navigation()

  )



  $('.show-misc-modal').on 'click', (evt) ->
    evt.preventDefault()
    evt.stopPropagation()
    $('#misc_product_product_type').val($(this).data('productType'))
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
    fieldName = $('#quoter .misc-field-name').val()
    if fieldName.length
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


  $('#quoter .create-field').on 'click', (evt) ->
    evt.preventDefault()
    quoteMiscs()

  $('#quoter .misc-field-name').on 'keypress', (evt) ->
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

  productType = categoryId = null
  if $('.editable').length
    $('.editable').editable
      event: 'click'
      callback: (data) ->

        id = data.$el.attr('klass')


        content = Number(data.content)
        if content == 0
          data.$el.text(0)
        else
          data.$el.text(content)

        sum = 0.0
        $('.editable[klass=' + id + ']').each ->
          value = Number($(this).text())
          if value > 0
            sum += value
          
      

        $('.total[klass=' +  id + ']').text(sum.toFixed(2))



  $('.save-product-quantity').on 'click', (evt) ->
    evt.preventDefault()
    $('.live-data').modal('hide')
    $('.total[data-product-id]').each ->
      value = Number($(this).text())
      id = ".quantity##{categoryId}#{$(this).attr('klass')}"
      if value > 0
        $(id).val(value)
      $(id).trigger('keyup')

  $('[data-target="#live-data"]').on 'click', ->
    categoryId = $(this).data('id')
    productType = $(this).data('productType')
    if productType == 'cabinet'
      $('.laminate-product').hide()
      $('.cabinet-product').show()
    else
      $('.laminate-product').show()
      $('.cabinet-product').hide()


    $('td.total').each ->
      productId = $(this).data('productId')
      $(this).attr('id', "#{productId}")
      $(this).removeAttr('klass')
      $(this).attr('klass', "#{productId}")

    $('td.editable').each ->
      productId = $(this).data('productId')
      $(this).removeAttr('klass')
      $(this).data('id', "#{productId}")
      $(this).attr('klass', "#{productId}")
