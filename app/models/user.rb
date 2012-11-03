class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongo::Voter
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  embeds_many :authentications

  def self.find_for_facebook_oauth(omniauth, user = nil)
    info = omniauth.info
    token = omniauth.credentials.token

    user ||= User.where(:email => info.email).first
    user ||= User.create!(:email => info.email, :password => Devise.friendly_token[0,20])

    auth = user.authentications.where(:_type => FacebookAuthentication.to_s).first
    args = {
      provider: omniauth.provider,
      uid: omniauth.uid,
      token: token,
      email: info.email,
      first_name: info.first_name,
      last_name: info.last_name
    }
    unless auth
      user.authentications.create!(args, FacebookAuthentication)
    else
      auth.update_attributes!(args)
    end
    user
  end

  def auth(provider)
    authentications.where(:_type => "#{provider.to_s.camelize}Authentication").first
  end

  def full_name
    auth(:facebook).full_name
  end

end