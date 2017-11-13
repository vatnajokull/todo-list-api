module Response
  module JsonHelpers
    def response_schema(endpoint, action)
      JSON.parse(
        Rails.root.join('spec', 'fixtures', 'responses', 'api', 'v1', endpoint.to_s, "#{action}.json").read
      )
    end
  end
end
