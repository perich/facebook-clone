class User < ActiveRecord::Base
	before_save :add_name
	# For friend requests
	has_many :sent_requests, :foreign_key => :sender_id, :class_name => "Request"
	has_many :recieved_requests, :foreign_key => :recipient_id, :class_name => "Request"
	has_many :friendships
  has_many :friends, :through => :friendships
	# For post likes
	has_many :likes
	has_many :liked_posts, :through => :likes, :source => :post

	has_many :posts, :foreign_key => :author_id, :dependent => :destroy
	has_many :comments, :dependent => :destroy

  has_many :notifications, :dependent => :destroy

	has_one :wall, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :photos, :dependent => :destroy
  has_one :profile_photo, -> { where profile_photo: true }, :class_name => "Photo"
  has_one :cover_photo, -> { where cover_photo: true }, :class_name => "Photo"

  def self.search(search)
  	if search
  		where('name LIKE ?', "%#{search}%")
    else
      scoped
  	end
  end

  protected

  	def add_name
	  	self.name = "#{self.first_name} #{self.last_name}"
	end     

end
