class  Rcadmin::QuoteProduct < ActiveRecord::Base
  attr_accessible :quote_id, :product_id, :category_id, :quantity,
    :total_price, :status, :header_option, :hidden, :product_type

  belongs_to :quote
  belongs_to :category
  has_one :quote_category, -> (object) { where(quote_id: object.quote_id) },
    foreign_key: :category_id, primary_key: :category_id

  belongs_to :product, polymorphic: true

  scope :find_by_quote, ->(quote_id) { where(:quote_id=>quote_id) }

  scope :has_option, ->(value) { where(header_option: value) }



  def has_option?
    self.header_option == 'Yes'
  end

end
