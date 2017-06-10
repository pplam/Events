class Project < ApplicationRecord
  belongs_to :team
  belongs_to :owner, foreign_key: :owner_id, class_name: :User
  has_many :todos
  has_many :accesses, dependent: :destroy
  has_many :users, through: :accesses
  def people
    self.accesses
      .includes(:user)
      .map do |access|
        user = access.user
        user.define_singleton_method(:join_time) do
          access.created_at
        end
        user
      end
  end
end
