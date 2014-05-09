class Rcadmin::QuoteCategory < ActiveRecord::Base
  include ::QuoteCalculator
  attr_accessible :markup, :miscs
  belongs_to :quote
  belongs_to :category

  has_many :quote_products, -> (object){ where(quote_id: object.quote_id) },
    foreign_key: :category_id, primary_key: :category_id do
    include ProductTypeExtension
  end

  before_save do
    self.markup = 0 if markup.nil?
  end

end
