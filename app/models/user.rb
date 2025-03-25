class User <ActiveRecord::Base

  has_secure_password
  validates :handle, presence: true, length: {maximum: 40}, uniqueness: {case_sensitive: false}
  # users.password_hash in the database is a :string
  #validates :user_id, :presence => true, :uniqueness => true
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  has_many :comments
  has_many :topics

  geocoded_by :ip_address, latitude: :latitude, longitude: :longitude
  after_validation :geocode, :if =>lambda{ |t| t.ip_address_changed? }

  acts_as_voter

  def create_user!(user)
    user[:session_token] = SecureRandom.base64
    user
  end

  def self.create_with_omniauth(auth)
    User.create({ :handle => auth['info']['email'], :password => auth['uid'],
                  :password_confirmation => auth['uid'], :session_token => SecureRandom.base64,
                  :provider => auth['provider'], :email => auth['info']['email']  })
  end
end

