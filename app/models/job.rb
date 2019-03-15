class Job < ApplicationRecord
  
  belongs_to :pool , optional: true
  belongs_to :user , optional: true
  belongs_to :company , optional: true
  
  has_many :line_items
  accepts_nested_attributes_for :line_items, allow_destroy: true
  
  has_many :job_assign_visits
  accepts_nested_attributes_for :job_assign_visits, allow_destroy: true

  has_one :invoice
  
  
  def self.visit_plans(days, job)
    JobAssignVisit.where(job_id: job.id).delete_all
    start_date = job.start_date
    end_date = job.end_date
    while (days > 0) do
       
      JobAssignVisit.create(job_id: job.id, user_id: job.assign_to, start_date: start_date,
        end_date: end_date)
      start_date = start_date + 1.day
      days = days - 1
    end
  end
  
end
