module UserHelper
  #Return the gravatar for user
  def gravatar_for (user, options = {size: 80})
    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(user.email)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class:"img-circle")
  end
end
