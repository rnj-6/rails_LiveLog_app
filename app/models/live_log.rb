class LiveLog < ApplicationRecord
  belongs_to :live_event
  has_one_attached :photo
end
