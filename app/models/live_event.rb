class LiveEvent < ApplicationRecord
  belongs_to :user
  has_one :live_log
end
