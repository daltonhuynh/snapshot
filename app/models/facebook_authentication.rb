class FacebookAuthentication < Authentication
  field :token
  field :email
  field :first_name
  field :last_name

  validates_presence_of :token, :email, :first_name

  def handle
    email
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def profile_picture
    @client ||= Koala::Facebook::API.new(token)
    @client.get_picture("me")
  end
end
