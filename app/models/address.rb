class Address
  include Mongoid::Document

  field :country, type: String
  field :state,   type: String
  field :sity,    type: String
  field :street,  type: String

  embedded_in :hotel

  validates :country, :state, :sity, :street, presence: true
end
