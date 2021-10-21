require "rails_helper"

RSpec.describe GetTasks, type: :service do
  describe "#execute" do
    let(:user) { User.create(username: "username", password: "Aa111111")}
    let(:show_closed_tasks) { false }
    let(:subject) { described_class.new(user, show_closed_tasks).execute }

    context "when user is nil" do
      let(:user) { nil }
      it { expect(subject).to eq([]) }
    end

    context "default case" do
      # todo use factory_bot
      let!(:opened_task) { Task.create(user: user, state: "opened")}
      let!(:in_progress_task) { Task.create(user: user, state: "in_progress")}
      let!(:closed_task) { Task.create(user: user, state: "closed")}
      let!(:removed_task) { Task.create(user: user, state: "removed")}

      it "returns opened tasks" do
        expect(subject.pluck(:state)).to include('opened')
      end

      it "returns in_progress tasks" do
        expect(subject.pluck(:state)).to include('in_progress')
      end

      it "won't return removed tasks" do
        expect(subject.pluck(:state)).not_to include('removed')
      end

      it "won't return closed tasks" do
        expect(subject.pluck(:state)).not_to include('closed')
      end
    end

    context "with show_closed_tasks" do
      let!(:closed_task) { Task.create(user: user, state: "closed")}
      let(:show_closed_tasks) { true }

      it "returns closed tasks" do
        expect(subject.pluck(:state)).to include('closed')
      end
    end
  end
end