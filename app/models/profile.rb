class Profile < ActiveRecord::Base
  validates :first_name, :last_name, :profession, :tech_of_choice, :years_experience, presence: true
  validates :years_experience, numericality: { only_integer: true }
  validates :willing_to_manage, inclusion: { in: [true, false], message: "must be true or false" }
      
  belongs_to :user
end
