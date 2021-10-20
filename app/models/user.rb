class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  validates :username, uniqueness: true, presence: true, length: {minimum: 4, maximum: 16}
  validates :username, format: {with: /\A[a-zA-Z0-9]*\z/, messages: "only allows alphanumeric character"} # todo I18n

  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of :password, within: 8..16, allow_blank: true # todo: use devise config instead hardcode length range
  validates :password, format: {
    with: /\A(?:(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*)\z/,
    messages: "should contains at least 1 upper case, 1 lower case, 1 number" # todo I18n
  }

  has_many :tasks

  protected

  # Checks whether a password is needed or not. For validations only.
  # Passwords are always required if it's a new record, or if the password
  # or confirmation are being set somewhere.
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
