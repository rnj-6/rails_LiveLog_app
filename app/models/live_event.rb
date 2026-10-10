class LiveEvent < ApplicationRecord
  belongs_to :user
  has_one :live_log, dependent: :destroy

  validates :title, presence: true
  validates :event_date, presence: true
  validates :venue_name, presence: true
end
