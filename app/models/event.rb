class Event < ApplicationRecord
  belongs_to :targetable, -> { with_deleted }, polymorphic: true
  belongs_to :resultable, polymorphic: true, optional: true
  belongs_to :user
end
