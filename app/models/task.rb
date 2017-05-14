class Task < ActiveRecord::Base
  validates :title, :list_id, :priority, presence: true

  belongs_to :list
end
