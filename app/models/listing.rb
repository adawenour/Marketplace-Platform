class Listing < ActiveRecord::Base
  if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"
  else
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg",
        :storage => :dropbox,
        :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
        :path => ":style/:id_:filename"
  end

	  validates_attachment :image, :content_type => { :content_type => %w(image/jpeg image/jpg image/png) } 
 	  validates :name, :description, :price, presence: true
  	validates :price, numericality: { greater_than: 0 }
  	validates_attachment_presence :image

    belongs_to :user
    has_many :order

    #add image url in form and pin params in controller
  def image_remote_url=(url_value)
    self.image = URI.parse(url_value) unless url_value.blank?
    super
  end

    
end

