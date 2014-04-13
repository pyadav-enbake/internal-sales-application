class MiscProduct < ActiveRecord::Base
  belongs_to :quote, class_name: 'Rcadmin::Quote'
  has_many :quote_products, dependent: :destroy, as: :product,
    class_name: 'Rcadmin::QuoteProduct', foreign_key: :product_id

  validates :title, :description, :price, :measurement_type, :customer_wording,
    presence: true

  validates :price, numericality: true, allow_blank: true

  attr_protected :id

  attr_accessor :product_type

  self.inheritance_column = 'kind'

  before_save :set_kind
  def set_kind
    self.kind = ( self.product_type == 'cabinet' ? "MiscCabinetProduct"  : 'MiscLaminateProduct' )
  end

  def type; end

  def customer_wording
    wording = read_attribute(:customer_wording)
    wording.presence || title
  end
end
