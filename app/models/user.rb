class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  validates :username, uniqueness: true, presence: true, length: {minimum: 4, maximum: 16}
  validates :username, format: {with: /\A[a-zA-Z0-9]*\z/, messages: "only allows alphanumeric character"}
end
