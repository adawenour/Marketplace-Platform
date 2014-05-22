class Order < ActiveRecord::Base
	validates :address, :city, :state, presence: true

	belongs_to :listings
	belongs_to :buyer, class_name: "User"
  	belongs_to :seller, class_name: "User"
end
