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
  has_many :customers, through: :contractors
  has_one :retail, ->{ where(last_name: 'Retail') }, class_name: "Contractor"
  has_many :non_retails, ->{ where.not(last_name: 'Retail') }, class_name: "Contractor"
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
    contractor = self.contractors.where(email: self.email).find_or_create_by!(attributes.except(:email))
    contractor.update!(attributes.except(:email)) if contractor.persisted?
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
      quotes.send(status.to_sym).where(created_at: Time.zone.now.all_year).count
    end

    method_name = "quotes_#{status}_ytd"
    define_method method_name do
      quotes.send(status.to_sym).where(created_at: Time.zone.now.all_year).
        joins(:quote_products).sum("quote_products.total_price")
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


  def month_range now = Time.now
    now = now - 4.months
    ranges = 1.upto(4).map do |month|
      (now + month.month).all_month
    end
  end

  def turned_in_data 
    now = Time.zone.now
    range = ( now - 1.year)..now
    data = quotes.joins(:quote_products).where(quotes: { created_at: range}).
      group("date_part('month', quotes.created_at)").sum("quote_products.total_price")
    months_range = 1.upto(12).map { |n| (now + n.month).month.to_f }
    data = months_range.inject({}) do |memo, month|
      data.has_key?(month)  ? (memo[month] = data[month]) : memo[month] = 0.0
      memo
    end.to_a
  end

  def unclosed_data
    quotes = []
    month_range.each_with_index do |range, index|
      quotes << [range.begin.month , self.quotes.unclosed.where(created_at: range).size]
    end
    quotes
  end

  def _turned_in_data
    quotes = []
    month_range.each_with_index do |range, index|
      quotes << [range.begin.month , self.quotes.turned_in.where(created_at: range).size]
    end
    quotes
  end

end
