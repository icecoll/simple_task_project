class Task < ApplicationRecord
  include AASM

  aasm column: "state" do
    state :opened, initial: true
    state :in_progress, :closed, :removed

    event :start do
      transitions from: :opened, to: :in_progress
    end

    event :done do
      transitions from: :in_progress, to: :closed
    end

    event :remove do
      transitions from: [:opened, :in_progress, :closed], to: :removed
    end
  end

  STATE_ENUM = %w[opened in_progress closed removed]

  validates :description, length: {maximum: 40, tokenizer: ->(str) { str.scan(/\w+/) }}
  validates :description, length: {maximum: 400}
  validates :state, inclusion: {in: STATE_ENUM}
  belongs_to :user
end
