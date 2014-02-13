class Rcadmin::Category < ActiveRecord::Base
    has_one :contractor, :through => :contractor_categories
    has_many :contractor_categories
    validates_presence_of :name
    attr_accessible :name,:description,:status,:quote_id

    scope :default, -> {  where(:quote_id => 0)  }

    def to_s
      "#{name}"
    end

    #has_many :subcategories, dependent: :destroy
    #has_many :products, dependent: :destroy
end
