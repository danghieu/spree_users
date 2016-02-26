Spree::Product.class_eval do
  has_many :likes, :class_name => "Dish::Like", foreign_key: 'product_id'
  has_many :users, :through => :likes, :class_name => "Spree::User"

  accepts_nested_attributes_for :likes,
             :reject_if => :all_blank,
             :allow_destroy => true
  accepts_nested_attributes_for :users


  def current_user_like?(user_id)
  	return false if user_id.blank?
  	self.likes.pluck(:user_id).include?(user_id)
  end

  def approved_comments
      Dish::Comment.where(product_id: self.id, status: 1)
    end
end