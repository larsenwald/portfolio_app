require 'rails_helper'

RSpec.describe Student, type: :model do
  it "is valid with valid attributes" do
    student = Student.new(first_name: "John", last_name: "Doe", school_email: "john@msudenver.edu", major: "Computer Science", expected_graduation_date: "2025-06-01")
    expect(student).to be_valid
  end

  it "is invalid without a first name" do
    student = Student.new(last_name: "Doe", school_email: "john@msudenver.edu", major: "Computer Science", expected_graduation_date: "2025-06-01")
    expect(student).to_not be_valid
  end
end