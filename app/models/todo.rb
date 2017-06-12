class Todo < ApplicationRecord
  acts_as_paranoid
  after_initialize :init

  belongs_to :project
  belongs_to :creator, foreign_key: :creator_id, class_name: :User
  belongs_to :executor, foreign_key: :executor_id, class_name: :User
  has_many :comments

  has_many :target_events, as: :targetable, class_name: :Event, foreign_key: :targetable_id
  has_many :result_events, as: :resultable, class_name: :Event, foreign_key: :resultable_id

  enum status: [ :ongoing, :finished ]

  def init
    self.status ||= :ongoing
  end
end
