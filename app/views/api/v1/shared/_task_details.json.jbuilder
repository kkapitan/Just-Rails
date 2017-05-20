json.partial! '/api/v1/shared/task_basic', task: task

json.priority task.priority
json.due task.due.to_f if task.due?
