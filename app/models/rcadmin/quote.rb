class Rcadmin::Quote < ActiveRecord::Base
  include ::QuoteCalculator
  validates_presence_of :contractor_id,:customer_id
  attr_accessible :contractor_id, :customer_id, :category, :status,
    :delivery_date,:sales_closing_potential, :cabinet_types_info, 
    :countertop_designs_info,:notes, :quote_categories_attributes, :miscs,
    :quote_products_attributes, :product_type_selections_attributes
  

  has_many :misc_products, dependent: :destroy
  has_many :misc_cabinet_products, dependent: :destroy
  has_many :misc_laminate_products, dependent: :destroy
  has_many :quote_misc_products, dependent: :destroy, through: :misc_products, source: :quote_products

  belongs_to :contractor
  belongs_to :customer
  has_many :quote_product, dependent: :destroy # TODO: remove this after replacing all occurences 

  has_many :quote_products, dependent: :destroy do
    %w(cabinet laminate misc_cabinet misc_laminate).each do |product_type|
      klass_name = "#{product_type}_product".classify
      method_name = product_type.pluralize

      define_method method_name do
        where(product_type: klass_name)
      end

    end
  end

  accepts_nested_attributes_for :quote_products, reject_if: proc { |attrs| attrs['quantity'].blank? }


  has_many :product_type_selections, dependent: :destroy
  has_many :product_types, through: :product_type_selections
  has_many :selection_types, through: :product_type_selections
  accepts_nested_attributes_for :product_type_selections


  belongs_to :cabinet_type
  belongs_to :countertop_design

  has_many :quote_categories
  has_many :categories, through: :quote_categories
  accepts_nested_attributes_for :quote_categories
  
  scope :find_by_customer, ->(customer_id) { where(:customer_id=>customer_id) }
  scope :current_month_quotes, -> { where("created_at >= ? AND created_at <= ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) }
  scope :current_year_quotes, -> { where("created_at >= ? AND created_at <= ?", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }


  STATUSES = ['Draft', 'Sent to Client', 'Negotiations', 'In Contract', 'Turned In']
  RATING = ['Very Poor', 'Poor', 'Fair', '50/50', 'Strong', 'Very Strong']

  STATUSES.each_with_index do |status, index|
    method_name = status.gsub(" ", "_").underscore
    define_method "#{method_name}!" do
      update_attribute(:status, index)
    end
  end


  def selection_value_for category_id, type
    product_selector = self.product_type_selections.joins(:product_type).
      where(category_id: category_id).where("LOWER(product_types.name) = ?", type.downcase).first
    return if product_selector.nil?
    product_selector.name.presence || product_selector.selection_type.name
  end


  def remove_category category_id = nil
    quote_category = self.quote_categories.where(category_id: category_id).first
    quote_category and quote_category.destroy
  end

  def categories_with_products(option = 'Yes')
    products_having_option = self.quote_product.has_option(option).
      joins(:category).includes(:category).references(:categories).
      order("LOWER(categories.name)").group_by do |quote_product|
        quote_product.category
      end
  end

  def categories_with_option_products
    categories_with_products('Yes')
  end

  def categories_without_option_products
    categories_with_products('No')
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
  
  def self.copy_quote(exist_quote,customer_id)
    return @quote if @quote
    
    @quote = Rcadmin::Quote.new
    
    @quote.contractor_id = exist_quote.contractor_id
    @quote.customer_id = customer_id
    @quote.category = exist_quote.category
    @quote.status = exist_quote.status
    @quote.delivery_date = exist_quote.delivery_date
    @quote.sales_closing_potential = exist_quote.contractor_id
    @quote.cabinet_types_info = exist_quote.cabinet_types_info
    @quote.countertop_designs_info = exist_quote.countertop_designs_info
    @quote.notes = exist_quote.notes
    
    @quote
    
  end
  
  def self.extra_quote(quote_id)
    
    @salesadmin_category = Rcadmin::Category.where(quote_id: quote_id)
    return @salesadmin_category
  end

  def self.extra_quote_ids(quote_id)
    
    @salesadmin_category_ids = Rcadmin::Category.where(quote_id: quote_id).pluck(:id)
    return @salesadmin_category_ids
  end


  def self.merger_quote_name(quote_id)
    @all_category_name = Rcadmin::Category.where(quote_id: quote_id,quote_id: 0).pluck(:name)
    
    return @all_category_name
  end

end
