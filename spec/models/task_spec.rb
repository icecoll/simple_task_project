require "rails_helper"

RSpec.describe Task, type: :model do
  describe "validations" do
    it { should validate_length_of(:description).is_at_most(400) }

    context "description words count" do
      it "should be too long when exceeds 40" do
        task = Task.new(description: "foo " * 41)
        expect(task.valid?).to be_falsy
        expect(task.errors.where(:description).last.type).to eq(:too_long)
      end

      it "should be valid when within 40" do
        task = Task.new(description: "foo " * 40)
        expect(task.valid?).to be_falsy
        expect(task.errors.where(:description).present?).to be_truthy
      end
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "AASM" do
    context "state" do
      let(:opened_task) { Task.new }
      let(:in_progress_task) { Task.new(state: "in_progress") }
      let(:closed_task) { Task.new(state: "closed") }

      it { expect(opened_task).to have_state(:opened) }
      it { expect(opened_task).to transition_from(:opened).to(:in_progress).on_event(:start) }
      it { expect(opened_task).to transition_from(:opened).to(:removed).on_event(:remove) }
      it { expect(opened_task).to_not allow_transition_to(:done) }

      it { expect(in_progress_task).to have_state(:in_progress) }
      it { expect(in_progress_task).to transition_from(:in_progress).to(:closed).on_event(:done) }
      it { expect(in_progress_task).to transition_from(:in_progress).to(:removed).on_event(:remove) }
      it { expect(in_progress_task).to_not allow_transition_to(:opened) }

      it { expect(closed_task).to transition_from(:closed).to(:removed).on_event(:remove) }
      it { expect(closed_task).to_not allow_transition_to(:opened) }
      it { expect(closed_task).to_not allow_transition_to(:in_progress) }
    end
  end
end
