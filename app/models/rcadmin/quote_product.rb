class  Rcadmin::QuoteProduct < ActiveRecord::Base
  attr_accessible :quote_id, :product_id, :category_id, :quantity,
    :total_price, :status, :header_option, :hidden, :product_type

  belongs_to :quote
  belongs_to :category
  has_one :quote_category, -> (object) { 
    if object.is_a? JoinDependency::JoinAssociation
      where(quote_id: Rcadmin::QuoteCategory.arel_table[:quote_id])
    else
      where(quote_id: object.quote_id) 
    end
  }, foreign_key: :category_id, primary_key: :category_id

  belongs_to :product, polymorphic: true

  delegate :factor, :percentage, to: :quote_category
  delegate :title, :price, :measurement_type, to: :product


  scope :find_by_quote, ->(quote_id) { where(:quote_id=>quote_id) }

  scope :has_option, ->(value) { where(header_option: value) }

  def options_total_price
    (self.total_price * (percentage/100) * factor).round(2)
  end

  def has_option?
    self.header_option == 'Yes'
  end

end
