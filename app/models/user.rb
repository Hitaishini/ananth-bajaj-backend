class User < ActiveRecord::Base
  audited
  # Features
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  
  # Associations
  has_one :profile
  has_one :hog_registration
  has_many :test_rides
  has_many :my_bikes
  has_many :notifications, foreign_key: :recipient_id
  has_one :wishlist, :dependent => :destroy
  has_many :rides, through: :user_rides
  has_many :user_rides
  has_many :events, through: :user_events
  has_many :user_events
  has_many :my_docs
  has_one :notification_count
  has_one :version_control, :dependent => :destroy
  has_many :used_bikes, :dependent => :destroy
  has_many :service_bookings, :dependent => :destroy
  has_many :payments, :dependent => :destroy

  # Validations
  has_many :authentication_tokens, dependent: :destroy
  #validates :authentication_token, :uniqueness => true
  validates :password, presence: false
  validates_confirmation_of :password

  validates_uniqueness_of :email, if: Proc.new { |a| a.email.present? }, :on => :create
  #validate :validate_email_uniqness, :on => :create
  validates_uniqueness_of :facebook_id, if: Proc.new { |a| a.facebook_id.present? }

  # Callbacks
  before_save :ensure_authentication_token
  accepts_nested_attributes_for :profile
  after_create :create_wishlist
  after_create :create_app_version_control
  #validation
  after_create :remove_gmail_users

  #validation
  def remove_gmail_users
    logger.info "=========before save users========"
    if self.email.present? 
      gmail_count = User.where(email: self.email).count
      User.where(email: self.email).destroy_all if self.email && gmail_count > 1
     end
  end

  #setting current user in model
  def self.current_user
    Thread.current[:current_user]
  end

  def self.current_user=(usr)
    Thread.current[:current_user] = usr
  end

  def update_device_token(params)
    if params["session"]["android_token"]
      self.update_attribute(:android_token, params[:session][:android_token])
    else params["session"]["ios_token"]
      self.update_attribute(:ios_token, params[:session][:ios_token])
    end
  end 

  def update_device_token_with_social(params)
    if params["user"]["android_token"]
      self.update_attribute(:android_token, params[:user][:android_token])
    else params["user"]["ios_token"]
      self.update_attribute(:ios_token, params[:user][:ios_token])
    end
  end 

  def self.import(file)
    begin     
      CSV.foreach(file.path, headers: true) do |row|
        user = find_by_id(row["id"]) || new
        attributes = row.to_hash
        user.email = attributes['Email Id*']
        user.password = attributes['Password*']
        user.role = "guest"
          if user && user.save!
             Profile.create(user_id: user.id, full_name: attributes['Full Name*'], dob: attributes['Date Of Birth(o)'], marriage_anniversary_date: attributes['Anniversary(o)'], mobile: attributes['Mobile Number*'])
             NotificationCount.create(user_id: user.id)
          end
       end
    rescue StandardError => e 
      raise "Error on row #{$.}====#{e.message}==="    
    end 
 end

def notification_enabled? action

  case action
  when 'Bookings'
    return self.try(:profile).try(:notifiable_bookings)
  when 'Events'
    return self.try(:profile).try(:notifiable_events)
  when 'Accessories'
    return self.try(:profile).try(:notifiable_accessories)
  when 'Offer'
    return self.try(:profile).try(:notifiable_offers)
  when 'Tips'
    return self.try(:profile).try(:notifiable_tips)
  else
    return true
  end

end    

def send_password_reset
  generate_token(:reset_password_token)
  logger.info "==========#{self.reset_password_token}======"
  self.reset_password_sent_at = Time.zone.now
  self.save
  UserMailer.delay.password_reset(self)
end

def generate_token(column)
    loop do 
       self.reset_password_token = SecureRandom.urlsafe_base64
      break unless User.exists?(reset_password_token: self.reset_password_token)
    end
    self.save
  # begin
  #   self[column] = SecureRandom.urlsafe_base64
  # end unless User.exists?(column => self[column])
end

def send_welcome_notification(template)
  Notification.create(recipient: self, actor: self, action: 'Offer', notifiable: self, notification_template: template)
  UserMailer.delay.welcome_user(self)
end

def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << ["Full Name*", "Email Id*", "Password*", "Mobile Number*", "Date Of Birth(o)", "Anniversary(o)"]
  end
end

#for uploading my bikes
def self.import_user_bikes(file)
    begin     
      CSV.foreach(file.path, headers: true) do |row|
        user = find_by_id(row["id"]) || new
        attributes = row.to_hash
        user.email = attributes['Email Id*']
        user.password = attributes['Password*']
        user.role = "guest"

          if user && user.save!
             Profile.create(user_id: user.id, full_name: attributes['Full Name*'], dob: attributes['Date Of Birth(o)'], marriage_anniversary_date: attributes['Anniversary(o)'], mobile: attributes['Mobile Number*'])
             NotificationCount.create(user_id: user.id)
             MyBike.create(bike: attributes['Bike Name*'], registration_number: attributes['Registration Number*'], purchase_date: attributes['Purchase Date*'], kms: attributes['KMS*'], last_service_date: attributes['Last Service Date'], insurance_expiry_date: attributes['Insurance Expiry'], user_id: user.id)
          end
       end
    rescue StandardError => e 
      raise "Error on row #{$.}====#{e.message}==="    
    end 
end

def self.user_bike_csv_download(options = {})
  CSV.generate(options) do |csv|
    csv << ["Full Name*", "Email Id*", "Password*", "Mobile Number*", "Date Of Birth(o)", "Anniversary(o)", "Bike Name*", "Registration Number*", "Purchase Date*", "KMS*", "Last Service Date", "Insurance Expiry"]
  end
end

private

def create_app_version_control
  user_id = self.id if self.id.present?
  VersionControl.create!(user_id: user_id, current_version: "2.0.0", latest_version: "1.0.0")
end

def create_wishlist
  Wishlist.create(user_id: self.id)
end

end