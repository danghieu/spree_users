Spree::User.class_eval do
  	has_many :likes, :class_name => "Dish::Like", foreign_key: 'user_id'
  	has_many :products, :through => :likes, :class_name => "Spree::Product"

  	accepts_nested_attributes_for :likes,
        :reject_if => :all_blank,
        :allow_destroy => true
    accepts_nested_attributes_for :products

    def change_password(password_params)
    	if self.valid_password?(password_params[:old])
          	self.password = password_params[:new] 
          	save!
          	return true
      	else
      		return false
      	end
    end


        
end