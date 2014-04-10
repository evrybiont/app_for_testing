class Hotel
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,               type: String
  field :star_rating,         type: Integer
  field :breakfast_included,  type: Boolean
  field :room_description,    type: String
  field :price_for_room,      type: Integer

  mount_uploader :photo, PhotoUploader

  embeds_one  :address
  embeds_many :comments
  accepts_nested_attributes_for :address
  belongs_to :user

  validates :title, presence: true
  validates :star_rating, numericality: { greater_than: 0, less_than: 6 }
  validates :price_for_room, presence: true, numericality: { only_integer: true, greater_than: 5 }

  delegate :country, :state, :sity, :street, to: :address

  scope :top, ->(size) { desc(:star_rating).limit(size) }
end
