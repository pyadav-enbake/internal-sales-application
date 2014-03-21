class Rcadmin::Product < ActiveRecord::Base
  validates_presence_of :subcategory_id,:title,:price,:measurement_type,:status
  attr_accessible :subcategory_id, :title, :measurement_type, :price,
    :description, :status, :customer_wording

  belongs_to :subcategory 
  #belongs_to :category 
  has_many :quote_product,dependent: :destroy

  #scope :find_by_category, ->(category_id) { where(:category_id=>category_id) }

  def self.base_products
    @base_subcategory ||= begin 
      base_subcategory = Rcadmin::Subcategory.find_by(name: "Base")
      if base_subcategory
        where(subcategory_id: base_subcategory.id)
      else
        none
      end
    end
  end
end
