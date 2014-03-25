class  Rcadmin::QuoteProduct < ActiveRecord::Base
  attr_accessible :quote_id, :product_id, :category_id, :quantity,
    :total_price, :status, :header_option, :hidden, :product_type

  belongs_to :quote
  belongs_to :category

  belongs_to :product, polymorphic: true

  scope :find_by_quote, ->(quote_id) { where(:quote_id=>quote_id) }

  scope :has_option, ->(value) { where(header_option: value) }








end
