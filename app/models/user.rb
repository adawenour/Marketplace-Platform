class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

          if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }
  else
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" },
        :storage => :dropbox,
        :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
        :path => ":style/:id_:filename"
  end

         validates_attachment :image, :content_type => { :content_type => %w(image/jpeg image/jpg image/png) }
         validates :name, presence: true

         has_many :listings, dependent: :destroy
         has_many :sales, class_name: "Order", foreign_key: "seller_id"
  		   has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
end
