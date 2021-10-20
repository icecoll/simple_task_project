require "rails_helper"

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        priority: "Priority",
        description: "Description",
        state: "State"
      ),
      Task.create!(
        priority: "Priority",
        description: "Description",
        state: "State"
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", text: "Priority".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "State".to_s, count: 2
  end
end
