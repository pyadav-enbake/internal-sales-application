class Rcadmin::Product < ActiveRecord::Base
  validates_presence_of :subcategory_id,:title,:price,:measurement_type,:status
  attr_accessible :subcategory_id, :title, :measurement_type, :price,
    :description, :status, :customer_wording, :type, :types

  belongs_to :subcategory 
  #belongs_to :category 
  has_many :quote_product, dependent: :destroy
  has_many :quote_products, dependent: :destroy, as: :product

  #scope :find_by_category, ->(category_id) { where(:category_id=>category_id) }

  self.inheritance_column = 'kind'

  # TYPES
  TYPES = ['wood-percentage', 'maple-percentage', 'wood', 'maple']
  def types=(types)
    self.types_masking = (types & TYPES).map { |type| 2**TYPES.index(type) }.sum
  end

  def types
    TYPES.reject { |type| ((types_masking || 0) & 2**TYPES.index(type)).zero? }
  end

  def type
    types.join(" ")
  end

  def customer_wording
    wording = read_attribute(:customer_wording)
    wording.presence || title
  end
  alias to_s customer_wording

  def self.base_products
    @base_subcategory ||= begin 
      base_subcategory = Rcadmin::Subcategory.where("LOWER(name) = ?", 'BASE'.downcase).first
      if base_subcategory
        where(subcategory_id: base_subcategory.id)
      else
        none
      end
    end
  end
end
