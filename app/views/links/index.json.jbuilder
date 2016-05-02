json.array!(@links) do |link|
  json.extract! link, :id, :title, :content, :cached_weighted_score
  json.url link_url(link, format: :json)
end
