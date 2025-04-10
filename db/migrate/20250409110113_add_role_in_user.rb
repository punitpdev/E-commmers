class AddRoleInUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :integer, default: 0
    add_index :users, :role
    User.all.each do |user|
      user.update_attribute(:role, 0)
    end
  end
end
