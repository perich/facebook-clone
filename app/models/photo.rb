class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :comments, :as => :commentable
	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
 	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/ 
 	validates_attachment_presence :photo
	validates_attachment_size :photo, :less_than => 5.megabytes
end
