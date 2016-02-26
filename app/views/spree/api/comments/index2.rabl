collection @comments 

node "comment" do |u|
  { :id => u.id,:title => u.title, :body => u.body, :rating => u.rating, :created_at => u.created_at,
  	:updated_at => u.updated_at, :belongs_to_current_user => u.belongs_to_current_user?(@current_user_id)
  }
end

child(:user) { attributes :first_name, :last_name, :email, :avatar_url }