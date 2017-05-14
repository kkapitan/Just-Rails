json.partial! '/api/v1/shared/list_basic', list: list

json.tasks list.tasks do |task|
  json.partial! '/api/v1/shared/task_basic', task: task
end