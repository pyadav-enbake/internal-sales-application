class Rcadmin::QuoteCategory < ActiveRecord::Base
  attr_accessible :markup
  belongs_to :quote
  belongs_to :category
  before_save do
    self.markup = 0 if markup.nil?
  end
end
