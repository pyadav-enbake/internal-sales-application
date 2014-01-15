class Rcadmin::Quote < ActiveRecord::Base
  validates_presence_of :customer_id
  attr_accessible :customer_id, :category, :status, :delivery_date,
    :sales_closing_potential, :cabinet_types_info, :countertop_designs_info

  belongs_to :customer
  has_many :quote_products, dependent: :destroy
  belongs_to :cabinet_type
  belongs_to :countertop_design

  serialize :cabinet_types_info
  serialize :countertop_designs_info


  scope :find_by_customer, ->(customer_id) { where(:customer_id=>customer_id) }


  def categories
    return Rcadmin::Category.none unless category?
    Rcadmin::Category.where(id: category_ids)
  end

  def category_ids
    @category_ids ||= category.split(',')
  end


  def parse_cabinet_types_info
    info = []
    if cabinet_types_info.is_a? Hash
      categories = Rcadmin::Category.where(id: cabinet_types_info.keys).to_a
      cabinet_types_info.each_pair do |category_id, section_ids|
        info << { product: categories.detect { |cat| cat.id == category_id.to_i }, sections: set_sections(section_ids) }
      end
    end
    info
  end

  def set_sections section_ids
    section_ids.map { |sid| "Selection #{sid}" }
  end

end
