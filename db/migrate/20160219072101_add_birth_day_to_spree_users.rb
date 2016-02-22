class AddBirthDayToSpreeUsers < ActiveRecord::Migration
  def change
  	add_column :spree_users, :birth_day, :date
  end
end
