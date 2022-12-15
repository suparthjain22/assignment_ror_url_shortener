class AddExpirationToUrls < ActiveRecord::Migration[6.1]
  def change
    add_column :urls, :expiration, :datetime
    add_column :urls, :is_expired, :boolean
  end
end


