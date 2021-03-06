class Rcadmin::QuoteCategory < ActiveRecord::Base
  include ::QuoteCalculator
  attr_accessible :markup, :miscs
  belongs_to :quote
  belongs_to :category

  has_many :quote_products, -> (object){ 
    if object.is_a? JoinDependency::JoinAssociation
      where(quote_id: Rcadmin::QuoteProduct.arel_table[:quote_id])
    else
      where(quote_id: object.quote_id) 
    end
  },
    foreign_key: :category_id, primary_key: :category_id do
    include ProductTypeExtension
  end

  before_save do
    self.markup = 0 if markup.nil?
  end

end
