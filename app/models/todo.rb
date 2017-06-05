class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :creator, foreign_key: :creator_id, class_name: :User
  belongs_to :executor, foreign_key: :executor_id, class_name: :User
  has_many :comments

  # enum status: {unassigned: 1, ongoing: 2, finished: 3}
  enum status: [ :unassigned, :ongoing, :finished ]
end
