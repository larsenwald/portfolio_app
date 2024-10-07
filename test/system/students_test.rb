require "application_system_test_case"

class StudentsTest < ApplicationSystemTestCase
  setup do
    @student = Student.create(first_name: "John", last_name: "Doe", school_email: "jdoe@university.edu", major: "CS", expected_graduation_date: "2025-06-01")
  end

  # Test visiting the index page
  test "visiting the index" do
    visit students_url
    assert_selector "h1", text: "Students"
  end

  # Test creating a new valid student
  test "should create student" do
    visit students_url
    click_on "New student"

    fill_in "First name", with: "Jane"
    fill_in "Last name", with: "Smith"
    fill_in "School email", with: "jsmith@university.edu"
    fill_in "Major", with: "IT"
    fill_in "Expected graduation date", with: "2025-12-01"
    click_on "Create Student"

    assert_text "Student was successfully created"
  end

  # Test creating a student with missing required fields
  test "should not create student with missing fields" do
    visit students_url
    click_on "New student"

    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "School email", with: ""
    fill_in "Major", with: ""
    click_on "Create Student"

    assert_text "First name can't be blank"
    assert_text "Last name can't be blank"
    assert_text "School email can't be blank"
    assert_text "Major can't be blank"
  end

  # Test that a duplicate school email should not be allowed
  test "should not create student with duplicate email" do
    visit students_url
    click_on "New student"

    fill_in "First name", with: "Duplicate"
    fill_in "Last name", with: "Student"
    fill_in "School email", with: @student.school_email # Uses the existing student's email
    fill_in "Major", with: "IT"
    fill_in "Expected graduation date", with: "2026-06-01"
    click_on "Create Student"

    assert_text "School email has already been taken"
  end

  # Test that invalid email formats are not allowed
  test "should not create student with invalid email format" do
    visit students_url
    click_on "New student"

    fill_in "First name", with: "Invalid"
    fill_in "Last name", with: "Email"
    fill_in "School email", with: "invalid-email" # Invalid format
    fill_in "Major", with: "IT"
    fill_in "Expected graduation date", with: "2026-06-01"
    click_on "Create Student"

    assert_text "School email is invalid"
  end

  # Test updating a student
  test "should update student" do
    visit student_url(@student)
    click_on "Edit this student", match: :first

    fill_in "First name", with: "Updated"
    fill_in "Last name", with: @student.last_name
    fill_in "School email", with: "updated@university.edu"
    fill_in "Major", with: @student.major
    click_on "Update Student"

    assert_text "Student was successfully updated"
  end

  # Test destroying a student
  test "should destroy Student" do
    visit student_url(@student)
    click_on "Destroy this student", match: :first

    assert_text "Student was successfully destroyed"
  end
end
