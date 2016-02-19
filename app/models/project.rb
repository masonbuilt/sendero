class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :route

  validates_presence_of :user_id

  scope :active,    ->() { where(status: "active") }
  scope :completed, ->() { where(status: "completed") }

  state_machine :status, initial: :active do

    state :active, value: "active"
    state :completed, value: "completed"

    event :complete do 
      transition active: :completed
    end

    event :uncomplete do
      transition completed: :active
    end

  end

  def grade # To do: use Rails delegator
    route.grade
  end

end
