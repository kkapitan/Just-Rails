@lists.each do |list|
  json.partial! '/api/v1/shared/list_basic', list: list
end
