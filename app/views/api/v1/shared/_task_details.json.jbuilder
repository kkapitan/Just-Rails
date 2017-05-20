json.partial! '/api/v1/shared/task_basic', task: task

json.priority task.priority
json.deadline task.deadline.to_f if task.deadline?
