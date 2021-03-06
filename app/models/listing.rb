class Listing < ActiveRecord::Base
	if Rails.env.development?
			has_attached_file :image, :styles => { :medium => "300x", :thumb => "300x200>" }, :default_url => "images.jpg"
	else 
		has_attached_file :image, :styles => { :medium => "300x", :thumb => "200x200>" }, :default_url => "images.jpg",
		:storage => :dropbox,
		:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
		:path => ":style/:id_:filename"
	end
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :name, :description, :price, presence: true
	validates :price, numericality: { greater_than: 0 }
	validates_attachment_presence :image

	belongs_to :admin 
	has_many :orders
end