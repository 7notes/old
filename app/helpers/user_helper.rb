module UserHelper
	def blocked? id
		id = id.to_i
		Blacklist.exists?(account_id: id.to_i, user_id: $current_user.id)
	end
	def blackuser? id
		id = id.to_i
		$current_user.blacklists.exists?(user_id: id)
	end

	def follower? id
		id = id.to_i
		Favorite.exists?(account_id: id.to_i, user_id: $current_user.id)
	end
	def favorite? id
		id = id.to_i
		$current_user.favorites.exists?(user_id: id)
	end
end
