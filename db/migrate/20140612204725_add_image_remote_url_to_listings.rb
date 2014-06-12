class AddImageRemoteUrlToListings < ActiveRecord::Migration
  def change
    add_column :listings, :image_remote_url, :string
  end
end
