json.array!(@orders) do |order|
  json.extract! order, :id, :production_id, :desc
  json.url order_url(order, format: :json)
end
