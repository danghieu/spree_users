object @comment
attributes :id, :title, :body, :rating, :user_id, :product_id, :box_id, :status, :created_at, :updated_at
node(:belongs_to_current_user){|c| c.belongs_to_current_user?(@current_user_id)}