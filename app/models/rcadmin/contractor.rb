class Rcadmin::Contractor < ActiveRecord::Base
  has_many :categories, :through => :contractor_categories
  has_many :contractor_categories
  validates_presence_of :admin_id,:company_name,:email
  validates :email, presence: true, :email => true
  validates_uniqueness_of :email,:on => :create
  validates_presence_of :state,:city,:address,:zip
  validates_format_of :zip, :with => /^\d{5}(-\d{4})?$/,:multiline => true, :message => "should be in the form 12345 or 12345-1234"
  validates_presence_of:phone,:status
  validates :phone, :length => {:minimum => 6, :maximum => 25}, :format => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i }

  attr_accessible :admin_id,:first_name,:last_name,:email,:state,:city,:address,:zip,:phone,:status,:company_name

  belongs_to :admin
  has_many :customers,dependent: :destroy
  has_many :quotes, dependent: :destroy
  scope :default, -> {  where(:status => 0)  }
  #composed_of :name, :mapping => %w(first_name last_name)
  scope :find_by_adminid, ->(admin_id) { where("admin_id = ? OR admin_id = 0", admin_id).order(:id) }

  after_create :create_default_customer, if: :default_contractor?
  def create_default_customer
    attributes = {
      first_name: 'Romar',
      last_name: 'Retail',
      email: self.email,
      address: '23949 S Northern Illinois Dr',
      city: 'Channahon',
      state: 'IL',
      zip: '60410',
      phone: '8154679900',
      status: 0
    }
    customer = self.customers.where(email: self.email).first
    customer && customer.update!(attributes) || self.customers.create(attributes)
  end

  def default_contractor?
    self.company_name == 'Romar Cabinets'
  end

  def fullname
    "#{first_name} #{last_name}"
  end
  alias :to_s :fullname

  def full_address
    "#{address}, #{city} #{state} #{zip}"
  end

end
