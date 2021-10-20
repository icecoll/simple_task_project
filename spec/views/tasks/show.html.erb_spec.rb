require "rails_helper"

RSpec.describe "tasks/show", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      priority: "Priority",
      description: "Description",
      state: "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Priority/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/State/)
  end
end
