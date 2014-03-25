class MiscProduct < ActiveRecord::Base
  belongs_to :quote, class_name: 'Rcadmin::Quote'
  has_many :quote_products, dependent: :destroy, as: :product,
    class_name: 'Rcadmin::QuoteProduct', foreign_key: :product_id

  validates :title, :description, :price, :measurement_type, :customer_wording,
    presence: true

  validates :price, numericality: true, allow_blank: true

  attr_protected :id
end
