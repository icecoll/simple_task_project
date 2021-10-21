require "rails_helper"

RSpec.describe TasksHelper, type: :helper do
  describe "#state_change_button" do
    let(:state) { "opened" }
    let(:task) { Task.new(state: state) }
    let(:subject) { state_change_button(task) }

    context "when task state is opened" do
      it { expect(subject).to include("start") }
      it { expect(subject).to include("btn-outline-secondary") }
      it { expect(subject).to include("in_progress") }
    end

    context "when task state is in_progress" do
      let(:state) { "in_progress" }
      it { expect(subject).to include("done") }
      it { expect(subject).to include("btn-primary") }
      it { expect(subject).to include("closed") }
    end

    context "when task state is closed" do
      let(:state) { "closed" }
      it { expect(subject).to be_nil }
    end

    context "when task state is removed" do
      let(:state) { "removed" }
      it { expect(subject).to be_nil }
    end
  end
end
