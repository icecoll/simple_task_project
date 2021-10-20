class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :user
      t.string :priority
      t.string :description
      t.string :state

      t.timestamps
    end
  end
end
