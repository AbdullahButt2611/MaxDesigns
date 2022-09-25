class ProjectDetail < ApplicationRecord
    belongs_to :project, touch: true
    belongs_to :order, optional: true, touch: true
    belongs_to :user

    scope :details_added_by_user, ->(id) {where(user_id: id)}
    scope :details_added_by_user_in_month, ->(id, month) {where(user_id: id).where('extract(year from updated_at) = ?', DateTime.now.year.to_i).where('extract(month  from updated_at) = ?', month.to_i)}

    validates :task, presence: true, length: { minimum: 5 }
end