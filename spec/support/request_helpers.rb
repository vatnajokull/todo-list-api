module Request
  module JsonHelpers
    def body_as_json
      @body_as_json ||= JSON.parse(response.body).with_indifferent_access
    end
  end
end
