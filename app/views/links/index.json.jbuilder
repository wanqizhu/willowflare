json.array!(@links) do |link|
  json.extract! link, :id, :title, :url, :content, :cached_weighted_score
  json.url link_url(link, format: :json)
end
