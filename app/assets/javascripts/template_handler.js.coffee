class window.RoomCalculator
  constructor: (@el) ->

  roundUp: (number) ->
    Math.ceil(number * 100) / 100

  optionsProductTotal: ->
    @roundUp Number( $(@el).find('.options-product-total').data('optionsProductTotal') )

  optionsGrandTotal: ->
    @roundUp @optionsProductTotal() * @percentage() * @factor()

  cabinetTotal: ->
    @roundUp Number( $(@el).find('.cabinet-total').text() )

  laminateTotal: ->
    @roundUp Number( $(@el).find('.laminate-tops-total').text() )

  productTotal: ->
    @roundUp @laminateTotal() + @cabinetTotal()

  grandTotal: ->
    @roundUp Math.round( @productTotal() * @percentage() * @factor() + @miscs() + @corian() + @labor() )

  percentage: ->
    # @roundUp ( parseFloat( $(@el).find('.quote-percentage').text() ) / 100.0 ) || 0.59
    parseFloat( $(@el).find('.quote-percentage').text() ) / 100.0  || 0.59
    
  factor: ->
    @roundUp parseFloat( $(@el).find('.factor-total').val() ) || 1.0

  percentageValue: ->
    @roundUp @productTotal() * @percentage()

  delivery: ->
    return 0.0 if @grandTotal() == 0
    @roundUp parseInt( ( @grandTotal() / 5000 ) + 1 ) * 75

  subTotal: ->
    @roundUp @grandTotal() - @delivery()

  factorValue: ->
    @roundUp @preTax() - @percentageValue()

  preTax: ->
    @roundUp @subTotal() / ( 1 + @taxPercentage() )

  taxPercentage: ->
    @roundUp ( Number( $(@el).find('.quote-tax-percentage').text() ) / 100.0 ) || 0.01

  taxValue: ->
    @roundUp @preTax() * @taxPercentage()

  miscs: ->
    @roundUp ( Number( $(@el).find('.misc-total').text() ) * 1.0) || 0.0

  corian: ->
    @roundUp Number( $(@el).find('.corian-total').val()  ) || 0.0

  labor: ->
    @roundUp ( Number( $(@el).find('.labor-total').val() ) ) || 0.0

  updateView: ->
    $(@el).find('.cabinet-total').text( @cabinetTotal().toFixed(2) )
    $(@el).find('.laminate-tops-total').text( @laminateTotal().toFixed(2) )
    $(@el).find('.product-total').text( @productTotal().toFixed(2) )
    $(@el).find('.percentage-total').text( @percentageValue().toFixed(2) )
    $(@el).find('.factor-total').text( @factorValue().toFixed(2) )
    $(@el).find('.factor-calculated-value').text( @factorValue().toFixed(2) )
    # $(@el).find('.cabinet-total').text( @cabinetTotal().toFixed(2) )
    $(@el).find('.pre-tax-total').text( @preTax().toFixed(2) )
    $(@el).find('.tax-total').text( @taxValue().toFixed(2) )
    $(@el).find('.subtotal-total').text( @subTotal().toFixed(2) )
    $(@el).find('.delivery-total').text( @delivery().toFixed(2) )
    $(@el).find('.grand-total').text( @grandTotal().toFixed(2) )
    $(@el).find('.options-grand-total').text( @optionsGrandTotal().toFixed(2) )

