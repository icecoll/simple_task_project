require "rails_helper"

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      priority: "MyString",
      description: "MyString",
      state: "MyString"
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do
      assert_select "input[name=?]", "task[priority]"

      assert_select "input[name=?]", "task[description]"

      assert_select "input[name=?]", "task[state]"
    end
  end
end
