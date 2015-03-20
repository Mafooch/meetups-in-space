class Meetup < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :name,
    presence: true,
    length: { maximum: 30}
  validates :location,
    presence: true
  validates :description,
    length: { maximum: 300 },
    presence: true
end
