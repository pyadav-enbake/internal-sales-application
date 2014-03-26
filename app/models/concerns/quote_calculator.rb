module QuoteCalculator
  extend ActiveSupport::Concern

  included do
  end

  def cabinet_total
    @cabinet_total ||= self.quote_products.sum(:total_price)
  end

  def laminate_top_total
    @laminate_top_total ||= 0.0
  end

  def product_total
    @product_total ||= ( cabinet_total + laminate_top_total )
  end

  def percentage
    59 # TODO use db for 59 so super admin can control
  end

  def percentage_value
    @percentage_value ||= ( product_total / 100 * percentage )
  end

  def factor
    1.2
  end

  def factor_value
    @factor_value ||= ( percentage_value * factor ) - ( tax + delivery )
  end

  def pre_tax
    @pre_tax ||= ( percentage_value + factor + corian )
  end

  def tax_percentage
    8.0
  end

  def tax_value
    @tax_value ||= ( pre_tax / 100 * tax_percentage )
  end

  def sub_total
    @sub_total ||= ( pre_tax + tax_value )
  end

  def labor
    @labor ||= ( miscs && miscs['labor'].to_f || 0.0 )
  end

  def delivery
    @deliver ||= ( sub_total / 5000  + 1 ) * 75
  end

  def corian
    @corian ||= miscs && miscs['corian'].to_f || 0.0
  end

  def grand_total
    sub_total + delivery
  end

  module ClassMethods
  end
end
