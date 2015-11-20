json.links do
  json.self api_v1_language_index_url
end
json.data do
  json.array! @results do |item|
    json.id item.id
    json.type 'language'
    json.attributes do
      json.name item.name
      json.type item.type
      json.designed_by item.designed_by
    end
  end
end
