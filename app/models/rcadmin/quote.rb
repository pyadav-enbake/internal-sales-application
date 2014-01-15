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
    @categories ||= Rcadmin::Category.where(id: category_ids)
  end

  def category_ids
    @category_ids ||= category.split(',')
  end



  # Isolate dependencies this would change in future soon

  def parse_countertop_designs_info
    return @cinfo if @cinfo
    @cinfo = []
    if countertop_designs_info.is_a? Hash
      categories = Rcadmin::Category.where(id: countertop_designs_info.keys).to_a
      countertop_designs_info.each_pair do |category_id, countertop_design_hash|
        @cinfo << { 
          category: categories.detect { |cat| cat.id == category_id.to_i },
          countertop_designs: extract_countertop_design_from(countertop_design_hash)
        }
      end
    end
    @cinfo
  end

  def extract_countertop_design_from countertop_design_hash
    countertop_designs = Rcadmin::CabinetType.where(id: countertop_design_hash.keys).to_a
    info = []
    countertop_design_hash.each_pair do |countertop_design_id, selection_id|
      info << { 
        countertop_design: countertop_designs.detect { |ct| ct.id == countertop_design_id.to_i }, 
        selection: "Selection #{selection_id.first}" 
      }
    end
    info
  end

  def parse_cabinet_types_info
    return @info if @info
    @info = []
    if cabinet_types_info.is_a? Hash
      categories = Rcadmin::Category.where(id: cabinet_types_info.keys).to_a
      cabinet_types_info.each_pair do |category_id, cabinet_type_hash|
        @info << { 
          category: categories.detect { |cat| cat.id == category_id.to_i },
          cabinet_types: extract_cabinets_from(cabinet_type_hash)
        }
      end
    end
    @info
  end

  def extract_cabinets_from cabinet_type_hash
    cabinet_types = Rcadmin::CabinetType.where(id: cabinet_type_hash.keys).to_a
    info = []
    cabinet_type_hash.each_pair do |cabinet_type_id, selection_id|
      info << { 
        cabinet_type: cabinet_types.detect { |ct| ct.id == cabinet_type_id.to_i }, 
        selection: "Selection #{selection_id.first}" 
      }
    end
    info
  end

end
