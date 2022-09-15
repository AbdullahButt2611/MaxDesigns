class ProjectDetail < ApplicationRecord
    belongs_to :project
    belongs_to :order, optional: true
    belongs_to :user

    validates :task, presence: true, length: { minimum: 5 }
end