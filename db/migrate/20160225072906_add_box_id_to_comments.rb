class AddBoxIdToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :box_id, :integer
  end
end
