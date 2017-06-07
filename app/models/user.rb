class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :team, optional: true
  has_many :accesses, dependent: :destroy
  has_many :projects, through: :accesses
  has_many :created_todos, foreign_key: :creator_id, class_name: :Todo
  has_many :executed_todos, foreign_key: :executor_id, class_name: :Todo
  has_many :comments
end
