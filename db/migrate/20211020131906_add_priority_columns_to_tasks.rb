class AddPriorityColumnsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :is_important, :boolean, default: false
    add_column :tasks, :is_urgent, :boolean, default: false
  end
end
