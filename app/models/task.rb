class Task < ApplicationRecord
  include AASM

  aasm column: "state" do
    state :opened, initial: true
    state :in_progress, :closed, :deleted

    event :start do
      transitions from: :opened, to: :in_progress
    end

    event :done do
      transitions from: :in_progress, to: :closed
    end

    event :delete do
      transitions from: [:opened, :in_progress, :closed], to: :deleted
    end
  end

  STATE_ENUM = %w[opened in_progress closed deleted]

  validates :description, length: {maximum: 40, tokenizer: ->(str) { str.scan(/\w+/) }}
  validates :description, length: {maximum: 400}
  validates :state, inclusion: {in: STATE_ENUM}
  belongs_to :user
end
