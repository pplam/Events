class Team < ApplicationRecord
  belongs_to :owner, foreign_key: :owner_id, class_name: :User
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_many :projects
  # scope :members?, ->(yn) { users.joins(:team_users).where(team_users: {accepted: yn}) }
  def members(yn)
    self.team_users
      .includes(:user)
      .where(accepted: yn)
      .map do |tu|
        user = tu.user
        user.define_singleton_method(:applied_time) do
          tu.created_at
        end
        user.define_singleton_method(:accepted_time) do
          tu.updated_at
        end
        user
      end
  end

  def add_member(user)
    self.users << user
    # TeamUser
    #   .find_by(team_id: self.id, user_id: user.id)
    self.team_users.where(user_id: user.id)
      .first
      .update_attribute(:accepted, true)
  end
end
