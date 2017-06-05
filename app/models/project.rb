class Project < ApplicationRecord
  belongs_to :team
  has_many :todos
  has_many :accesses, dependent: :destroy
  has_many :users, through: :accesses
end
