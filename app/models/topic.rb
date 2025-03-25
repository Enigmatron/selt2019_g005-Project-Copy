class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  acts_as_votable

  geocoded_by :ip_address, latitude: :latitude, longitude: :longitude
  after_validation :geocode, :if =>lambda{ |t| t.ip_address_changed? }

  def self.search(string)
    topics = Topic.arel_table
    Topic.where(topics[:header].matches("%#{string}%"))
    # Topic.where("lower(header) REGEXP ?", string.downcase)
  end




end
