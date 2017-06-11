class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :own_teams, foreign_key: :owner_id, class_name: :Team
  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users
  has_many :accesses, dependent: :destroy
  has_many :projects, through: :accesses
  has_many :own_projects, foreign_key: :owner_id, class_name: :Project
  has_many :created_todos, foreign_key: :creator_id, class_name: :Todo
  has_many :executed_todos, foreign_key: :executor_id, class_name: :Todo
  has_many :comments

  def in_teams(yn)
    self.team_users
      .includes(:team)
      .where(accepted: yn)
      .map do |tu|
        team = tu.team
        team.define_singleton_method(:applied_time) do
          tu.created_at
        end
        team.define_singleton_method(:accepted_time) do
          tu.updated_at
        end
        team
      end
  end
end
