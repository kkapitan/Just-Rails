class AddDoneAndDeadlineToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :deadline, :date
    add_column :tasks, :done, :boolean, default: false
  end
end
