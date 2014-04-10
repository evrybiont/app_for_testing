class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, type: String

  embedded_in :hotel
  belongs_to :user

  validates :text, presence: true
end
