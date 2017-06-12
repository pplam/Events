class Comment < ApplicationRecord
  belongs_to :todo
  belongs_to :user
  has_many :event_results, as: :resultable, class_name: :Event
end
