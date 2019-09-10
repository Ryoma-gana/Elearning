module UsersHelper
    def gravatar_for(user,option={size:60})
        gravatar_id=Digest::MD5::hexdigest(user.email.downcase)
        image_size=option[:size]
        gravatar_url="https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{image_size}"

        image_tag(gravatar_url, alt: user.name)
    end
end
