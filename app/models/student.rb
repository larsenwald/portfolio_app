class Student < ApplicationRecord
  validates :first_name, :last_name, :school_email, :major, presence: true
  validates :school_email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email format" }
end
