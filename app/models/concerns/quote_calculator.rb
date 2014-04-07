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

  def grand_total
    @grand_total ||= (product_total * (percentage/100.0) * factor + extra_misc + corian + labor).round
  end

  def percentage
    ::AdminSetting[:coversheet_percentage]
  end

  def percentage_value
    @percentage_value ||=  ( percentage / 100.0 * product_total ).round(2)
  end

  def factor
    miscs && miscs['factor'].to_f.round(4) || 1.0
  end

  def sub_total
    @sub_total ||= ( grand_total - delivery ).to_f.round(2)
  end

  def pre_tax
    @pre_tax ||= ( sub_total / (1 +  tax_percentage / 100.0) ).to_f.round(2)
  end

  def delivery
    @deliver ||= ( ( grand_total / 5000  + 1 ) * 75 ).to_f.round(2)
  end


  def factor_value
    @factor_value ||= ( pre_tax - percentage_value )
  end


  def tax_percentage
    8.0
  end

  def tax_value
    @tax_value ||= ( pre_tax * tax_percentage / 100.0).to_f.round(2)
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

  module ClassMethods
  end
end