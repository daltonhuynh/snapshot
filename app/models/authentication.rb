class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  PROVIDERS = [:facebook]

  embedded_in :user

  field :provider
  field :uid

  validates_presence_of :provider, :uid
  validates_inclusion_of :provider, :in => PROVIDERS.map(&:to_s)

  def handle
    uid
  end
end
