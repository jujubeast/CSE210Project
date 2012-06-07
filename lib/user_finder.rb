module UserFinder

	def self.find_by_fb_id(fbid)
		user = User.where(:fb_id => fbid).first
	end

	def self.find_by_user_id(user_id)
		user = User.where(:id => user_id).first
	end

end