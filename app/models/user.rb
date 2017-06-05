class User < ApplicationRecord
  belongs_to :team
  has_many :accesses, dependent: :destroy
  has_many :projects, through: :accesses
  has_many :created_todos, foreign_key: :creator_id, class_name: :Todo
  has_many :executed_todos, foreign_key: :executor_id, class_name: :Todo
  has_many :comments
end
