class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :route

  validates_presence_of :user_id

  scope :active,    ->() { where(status: "active") }
  scope :complete, ->() { where(status: "complete") }

  state_machine :status, initial: :active do

    state :active, value: "active"
    state :complete, value: "complete"

    event :complete do 
      transition active: :complete
    end

    event :uncomplete do
      transition complete: :active
    end

  end

  def grade # To do: use Rails delegator
    route.grade
  end

end
