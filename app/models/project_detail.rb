class ProjectDetail < ApplicationRecord
    belongs_to :project, touch: true
    belongs_to :order, optional: true, touch: true
    belongs_to :user

    validates :task, presence: true, length: { minimum: 5 }
end