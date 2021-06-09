module ApplicationHelper

	def gravator_for(user, options= {size: 80})
		email = user.email.downcase
		hash_val = Digest::MD5.hexdigest(email)
		size = options[:size]
		gravator_url = "https://www.gravatar.com/avatar/#{hash_val}?s=#{size}"
		image_tag(gravator_url, alt: user.user_name, class: "rounded mx-auto d-block") 
	end
end
