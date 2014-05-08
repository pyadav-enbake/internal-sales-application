class Rcadmin::Category < ActiveRecord::Base
    has_one :contractor, :through => :contractor_categories
    has_many :contractor_categories

    has_many :quote_categories
    has_many :quotes, through: :quote_categories

    validates_presence_of :name
    validates_uniqueness_of :name, scope: [:name, :admin_id]
    attr_accessible :name,:description,:status,:quote_id

    scope :default, -> {  where(:quote_id => 0)  }

    def to_s
      "#{name}"
    end


    def dom_class
      self.name.to_s.parameterize
    end
    #has_many :subcategories, dependent: :destroy
    #has_many :products, dependent: :destroy
end
