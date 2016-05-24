json.array!(@surveydata) do |surveydatum|
  json.extract! surveydatum, :id, :email, :surveyresponse, :reward
  json.url surveydatum_url(surveydatum, format: :json)
end
