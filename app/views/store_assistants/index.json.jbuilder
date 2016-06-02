json.array!(@store_assistants) do |store_assistant|
  json.extract! store_assistant, :id
  json.url store_assistant_url(store_assistant, format: :json)
end
