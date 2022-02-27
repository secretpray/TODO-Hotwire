class Todo < ApplicationRecord
  enum status: %i[incomplete complete]

  validates_presence_of :name
  validates :status, inclusion: { in: statuses.stringify_keys.keys }
end
