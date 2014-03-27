module QuoteCalculator
  extend ActiveSupport::Concern

  included do
  end

  def cabinet_total
    @cabinet_total ||= self.quote_products.sum(:total_price).to_f.round(2)
  end

  def laminate_top_total
    @laminate_top_total ||= 0.0
  end

  def product_total
    @product_total ||= ( cabinet_total + laminate_top_total ).to_f.round(2)
  end

  def percentage
    ::AdminSetting[:coversheet_percentage] 
  end

  def percentage_value
    @percentage_value ||= ( product_total / 100 * percentage ).to_f.round(2)
  end

  def factor
    miscs && miscs['factor'].to_f.round(2) || 0.0
  end

  def factor_value
    @factor_value ||= ( ( percentage_value * factor ) - ( tax + delivery ) ).to_f.round(2)
  end

  def pre_tax
    @pre_tax ||= ( percentage_value + factor + corian + extra_misc ).to_f.round(2)
  end

  def tax_percentage
    8.0
  end

  def tax_value
    @tax_value ||= ( pre_tax / 100 * tax_percentage ).to_f.round(2)
  end

  def sub_total
    @sub_total ||= ( pre_tax + tax_value ).to_f.round(2)
  end

  def delivery
    @deliver ||= ( ( sub_total / 5000  + 1 ) * 75 ).to_f.round(2)
  end

  def corian
    miscs && miscs['corian'].to_f.round(2) || 0.0
  end

  def labor
    miscs && miscs['labor'].to_f.round(2) || 0.0
  end

  def extra_misc
    miscs && miscs.except("corian", "labor", "factor").values.map(&:to_f).sum || 0.0
  end


  def grand_total
    sub_total + delivery
  end

  module ClassMethods
  end
end
