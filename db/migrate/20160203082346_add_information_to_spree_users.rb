class AddInformationToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :first_name, :string
    add_column :spree_users, :last_name, :string
    add_column :spree_users, :avatar_url, :string
    add_column :spree_users, :sign_up_type, :string
  end
end
