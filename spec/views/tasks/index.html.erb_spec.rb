require "rails_helper"

RSpec.describe "tasks/index", type: :view do
  let(:user) { User.create(username: "username", password: "Aa111111") }
  before(:each) do
    sign_in(user)
    assign(:tasks, [
      Task.create!(
        user: user,
        description: "Description"
      ),
      Task.create!(
        user: user,
        description: "Description"
      )
    ])
    assign(:task, Task.new)
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", text: /Description/, count: 2
    assert_select "tr>td", text: /open/, count: 2
    assert_select "tr>td", text: /not impt/, count: 2
    assert_select "tr>td", text: /not urgt/, count: 2
  end
end
