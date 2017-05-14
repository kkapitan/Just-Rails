json.partial! '/api/v1/shared/task_basic', task: task

json.priority task.priority
json.deadline task.deadline
