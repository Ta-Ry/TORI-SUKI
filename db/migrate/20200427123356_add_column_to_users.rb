class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
    add_column :users, :profile_image_id, :string
    add_column :users, :introduction, :text
    add_column :users, :deleted_at, :boolean, null: false, default:false
  end
end
