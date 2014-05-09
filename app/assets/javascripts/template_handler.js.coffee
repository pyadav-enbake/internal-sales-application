class window.RoomCalculator
  constructor: (@el) ->

  cabinetTotal: ->
    Number( $(@el).find('.cabinet-total').text() )

  laminateTotal: ->
    Number( $(@el).find('.laminate-tops-total').text() )

  productTotal: ->
    @laminateTotal() + @cabinetTotal()

  grandTotal: ->
    Math.round( @productTotal() * @percentage() * @factor() + @miscs() + @corian() + @labor() )

  percentage: ->
    ( parseFloat( $(@el).find('.quote-percentage').text() ) / 100.0 ) || 0.59

  factor: ->
    parseFloat( $(@el).find('.factor-total').val() ) || 1.0

  percentageValue: ->
    @productTotal() * @percentage()

  delivery: ->
    return 0.0 if @grandTotal() == 0
    parseInt( ( @grandTotal() / 5000 ) + 1 ) * 75

  subTotal: ->
    @grandTotal() - @delivery()

  factorValue: ->
    @preTax() - @percentageValue()

  preTax: ->
    @subTotal() / ( 1 + @taxPercentage() )

  taxPercentage: ->
    ( Number( $(@el).find('.quote-tax-percentage').text() ) / 100.0 ) || 0.01

  taxValue: ->
    @preTax() * @taxPercentage()

  miscs: ->
    ( Number( $(@el).find('.misc-total').text() ) * 1.0) || 0.0

  corian: ->
    Number( $(@el).find('.corian-total').val()  ) || 0.0

  labor: ->
    ( Number( $(@el).find('.labor-total').val() ) ) || 0.0

  updateView: ->
    $(@el).find('.cabinet-total').text( @cabinetTotal().toFixed(2) )
    $(@el).find('.laminate-tops-total').text( @laminateTotal().toFixed(2) )
    $(@el).find('.product-total').text( @productTotal().toFixed(2) )
    $(@el).find('.percentage-total').text( @percentageValue().toFixed(2) )
    $(@el).find('.factor-total').text( @factorValue().toFixed(2) )
    $(@el).find('.factor-calculated-value').text( @factorValue().toFixed(2) )
    $(@el).find('.cabinet-total').text( @cabinetTotal().toFixed(2) )
    $(@el).find('.pre-tax-total').text( @preTax().toFixed(2) )
    $(@el).find('.tax-total').text( @taxValue().toFixed(2) )
    $(@el).find('.subtotal-total').text( @subTotal().toFixed(2) )
    $(@el).find('.delivery-total').text( @delivery().toFixed(2) )
    $(@el).find('.grand-total').text( @grandTotal().toFixed(2) )

