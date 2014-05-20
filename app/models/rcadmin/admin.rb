class Rcadmin::Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name,:last_name,:username
  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , :message => "Invalid Format" 
  validates :email, :presence => true, :email => true
  validates_uniqueness_of :email,:on => :create
  validates_presence_of :password ,:on => :create
  validates_confirmation_of :password_confirmation
  #validates_acceptance_of :terms_and_conditions, :accept => true
  attr_accessible :first_name,:last_name,:email,:username, :password, :password_confirmation, :remember_me,:terms_and_conditions,:role,:quote_category
  #validates :username, :presence => true

  has_many :contractors, dependent: :destroy
  has_many :quotes, through: :contractors
  has_many :categories, dependent: :destroy

  after_create :create_default_contractor
  def create_default_contractor
    attributes = {
      first_name: 'Romar',
      last_name: 'Retail',
      company_name: 'Romar Cabinets',
      email: self.email,
      address: '23949 S Northern Illinois Dr',
      city: 'Channahon',
      state: 'IL',
      zip: '60410',
      phone: '8154679900',
      status: 0
    }
    contractor = self.contractors.where(email: self.email).first_or_create! attributes
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end


  def role
    self.read_attribute(:role).inquiry
  end

  %w(turned_in negotiations).each do |status|
    method_name = "quotes_#{status}_count"
    define_method method_name do
      quotes.send(status.to_sym).count
    end
  end


  DEFAULT_ROOMS = [
    "Kitchen", "Bath 1", "Mstrr Bath", "Mud Bath", "2nd Lndry", "1st Lndry",
    "Ldry Top", "Powder 1", "Living Room", "Powder 2", "Mstr Bedroom", "4 Baths",
    "Closets", "Baths", "Bath 4", "Bath 5", "Bath 6", "Bsmt Bath", "Wetbar",
    "Office", "Fam Rm", "Xtra1", "Xtra 2", "Xtra 3", "Xtra 4"
  ]

  after_create :create_default_rooms
  def create_default_rooms
    DEFAULT_ROOMS.each do |room|
      self.categories.create_with(name: room, description: room, status: 0).find_or_create_by(name: room)
    end if role.sales_admin?
  end


  def quarter_range now = Time.now
    now = now.beginning_of_year
    ranges = [0, 3, 6, 9].map do |quarter|
      (now + quarter.month).all_quarter
    end
  end

  def unclosed_data
    quotes = []
    quarter_range.each_with_index do |quarter_range, index|
      quotes << [index + 1, self.quotes.unclosed.where(created_at: quarter_range).size]
    end
    quotes
  end

  def turned_in_data
    quotes = []
    quarter_range.each_with_index do |quarter_range, index|
      quotes << [index + 1, self.quotes.turned_in.where(created_at: quarter_range).size]
    end
    quotes
  end

end
