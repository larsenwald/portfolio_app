require "test_helper"

class StudentTest < ActiveSupport::TestCase

  test "should save student with valid attributes" do
    student = Student.new(first_name: "John", last_name: "Doe", school_email: "john@msudenver.edu", major: "CS", expected_graduation_date: "2025-06-01")
    assert student.save, "Student with valid attributes should be saved"
  end

  test "should not save student without first name" do
    student = Student.new(last_name: "Doe", school_email: "john@msudenver.edu", major: "CS", expected_graduation_date: "2025-06-01")
    assert_not student.save, "Student without first name should not be saved"
  end

  test "should not save student without last name" do
    student = Student.new(first_name: "John", school_email: "john@msudenver.edu", major: "CS", expected_graduation_date: "2025-06-01")
    assert_not student.save, "Student without last name should not be saved"
  end

  test "should not allow duplicate school_email" do
    student1 = Student.create(first_name: "John", last_name: "Doe", school_email: "john@msudenver.edu", major: "CS", expected_graduation_date: "2025-06-01")
    student2 = Student.new(first_name: "Jane", last_name: "Doe", school_email: "john@msudenver.edu", major: "CS", expected_graduation_date: "2025-06-01")
    assert_not student2.save, "Duplicate school_email should not be allowed"
  end

  test "should require valid school_email format" do
    student = Student.new(first_name: "John", last_name: "Doe", school_email: "invalid_email", major: "CS", expected_graduation_date: "2025-06-01")
    assert_not student.save, "Invalid email format should not be allowed"
  end

  test "should raise error if profile_picture is too big" do
    student = Student.new(first_name: "John", last_name: "Doe", school_email: "john@msudenver.edu", major: "CS", expected_graduation_date: "2025-06-01")
    student.profile_picture.attach(io: File.open(Rails.root.join('test/fixtures/files/large_image.png')), filename: 'large_image.png', content_type: 'image/png')

    assert_not student.valid?, "Profile picture too large should be invalid"
    assert_includes student.errors[:profile_picture], "is too big"
  end

  test "should save with a valid profile picture" do
    student = Student.new(first_name: "Jane", last_name: "Doe", school_email: "jane@msudenver.edu", major: "CS", expected_graduation_date: "2025-06-01")
    student.profile_picture.attach(io: File.open(Rails.root.join('test/fixtures/files/sample_image.jpg')), filename: 'sample_image.jpg', content_type: 'image/jpeg')
    assert student.save, "Valid student with profile picture should be saved"
  end
end
