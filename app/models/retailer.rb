class Retailer < ActiveRecord::Base
  belongs_to :quote
  attr_protected :id

  validates :first_name, :last_name, :title, :email, :address, :city, :state,
    :zip, :phone, presence: true

  def fullname
    "#{first_name} #{last_name}"
  end
  alias :to_s :fullname

  def full_address
    "#{address}, #{city} #{state} #{zip}"
  end
end
