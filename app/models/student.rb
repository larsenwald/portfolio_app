class Student < ApplicationRecord
  # Active Storage association
  has_one_attached :profile_picture

  # Validations
  validates :first_name, :last_name, :school_email, :major, :expected_graduation_date, presence: true
  validates :school_email, uniqueness: true
  validate :school_email_format
  validate :acceptable_image

  # Custom validation for email format
  def school_email_format
    unless school_email =~ /\A[\w+\-.]+@msudenver\.edu\z/i
      errors.add(:school_email, "must be an @msudenver.edu email address")
    end
  end

  # Validate profile picture for size and type
  def acceptable_image
    return unless profile_picture.attached?

    if profile_picture.blob.byte_size > 1.megabyte
      errors.add(:profile_picture, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(profile_picture.content_type)
      errors.add(:profile_picture, "must be a JPEG or PNG")
    end
  end
end
