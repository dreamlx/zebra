json.array!(@shop_stores) do |shop_store|
  json.extract! shop_store, :id, :title, :code, :contact, :mobile, :address
  json.url shop_store_url(shop_store, format: :json)
end
