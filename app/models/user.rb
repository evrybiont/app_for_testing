class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :token, type: String
  field :email, type: String
  field :encrypted_password, type: String, encrypted: true

  embeds_one :profile
  accepts_nested_attributes_for :profile
  has_many :hotels


  validates :token, presence: true
  validates :password, presence: true,
                       confirmation: true,
                       length: { in: 6..30 },
                       format: { with: /\A\p{Alnum}+\z/, message: I18n.t('errors.invalid_password') }

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,
                              message: I18n.t('errors.invalid_email') }

  delegate :full_name, to: :profile
end
