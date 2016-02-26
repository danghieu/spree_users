Dish::Comment.class_eval do

	def self.approved_comments
		self.where(status:1)
	end

	def move_to_trash
		self.status = 3
		save
	end

	def approve
		self.status = 1
		save
	end

	def belongs_to_current_user?(user_id)
		return false if user_id.blank?
		return true if self.user_id == user_id
	end

end