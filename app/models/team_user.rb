class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user

  after_initialize :init

  def init
    self.accepted  ||= false
  end
end
