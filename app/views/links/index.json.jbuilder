json.array!(@links) do |link|
  json.extract! link, :id, :title, :url, :content
  json.url link_url(link, format: :json)
end
