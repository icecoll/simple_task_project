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
  MAX_DESCRIPTION_WORDS = 40
  MAX_DESCRIPTION_LENGTH = 400

  validates :description, presence: true, length: {maximum: MAX_DESCRIPTION_LENGTH}
  validates :state, inclusion: {in: STATE_ENUM}
  validate :description_words_count_can_not_be_to_long

  belongs_to :user

  private

  def description_words_count_can_not_be_to_long
    if description && description.split(" ").length > MAX_DESCRIPTION_WORDS
      errors.add(:description, "must have at most #{MAX_DESCRIPTION_WORDS} words")
    end
  end
end
