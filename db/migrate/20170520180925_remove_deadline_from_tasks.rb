class RemoveDeadlineFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :deadline
  end
end
