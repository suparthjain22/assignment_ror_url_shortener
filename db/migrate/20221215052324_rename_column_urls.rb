class RenameColumnUrls < ActiveRecord::Migration[6.1]
  def change
    rename_column :urls, :is_expired, :is_active
  end
end
