class Profile
  include Mongoid::Document

  field :first_name, type: String
  field :last_name,  type: String

  embedded_in :user

  validates :first_name, :last_name, presence: true

  def full_name
    first_name + ' ' + last_name
  end
end
