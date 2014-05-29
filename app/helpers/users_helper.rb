module UsersHelper

	# Returns the Avatar for the given user
	def avatar_for(user)
		image_tag @user.avatar.url(:thumb), class: "avatar"
	end
end
