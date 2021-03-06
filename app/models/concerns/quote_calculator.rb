module QuoteCalculator
  extend ActiveSupport::Concern

  included do
  end


  def total
    @total ||= self.quote_products.group([:product_type, :header_option]).sum(:total_price)
  end

  def options_product_total
    @options_product_total ||= (
      total[['CabinetProduct', 'Yes']].to_f + total[['MiscCabinetProduct', 'Yes']].to_f +
      total[['LaminateProduct', 'Yes']].to_f + total[['MiscLaminateProduct', 'Yes']].to_f
    ).round(2)
  end

  def options_sipping_charges
    return options_grand_total if options_grand_total.zero?
    @options_shipping ||= ( ( options_grand_total / 5000  + 1 ).round * 75 )
  end

  def options_grand_total
    ( options_product_total * (percentage/100.0) * factor ).round(2)
  end

  def cabinet_total
    @cabinet_total ||= (
      total[['CabinetProduct', 'No']].to_f + total[['MiscCabinetProduct', 'No']].to_f
    ).round(2)
  end

  def laminate_top_total
    @laminate_top_total ||= (
      total[['LaminateProduct', 'No']].to_f + total[['MiscLaminateProduct', 'No']].to_f
    )
  end

  def product_total
    @product_total ||= ( cabinet_total + laminate_top_total ).to_f.round(2)
  end

  def grand_total
    @grand_total ||= (product_total * (percentage/100.0) * factor + extra_misc + corian + labor).round
  end

  def percentage
    @percentage ||= AdminSetting.find_by(name: 'coversheet_percentage').value.to_f
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
    return grand_total if grand_total.zero?
    return grand_total if self.respond_to?(:deliver) and !self.deliver?
    return 0 unless self.quote.deliver?
    @deliver ||= ( grand_total / 5000  + 1 ).round * 75
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
