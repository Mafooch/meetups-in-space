class Membership < ActiveRecord::Base
  belongs_to :meetup
  belongs_to :user

  validates :user_id,
    presence: true
  validates :meetup_id,
    presence: true
  # should check for uniqueness of combined columns
  validates :user,
   uniqueness: { scope: :meetup,
    message: "You have already joined this group!" }
end
