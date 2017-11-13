RSpec.configure do |config|
  config.swagger_root = Rails.root.join('public', 'apidoc')

  config.swagger_docs = {
    'v1/swagger.json' => {
      swagger: '2.0',
      basePath: '/api/v1',
      info: {
        title: 'ToDo List API',
        version: 'v1'
      },
      produces: ['application/vnd.api+json'],
      consumes: ['application/vnd.api+json'],
      securityDefinitions: {
        access_token: { type: 'apiKey', in: 'header', name: 'access-token' },
        token_type: { type: 'apiKey', in: 'header', name: 'token-type' },
        client: { type: 'apiKey', in: 'header', name: 'client' },
        uid: { type: 'apiKey', in: 'header', name: 'uid' }
      },
      security: [
        { access_token: [], token_type: [], client: [], uid: [] }
      ],
      paths: {},
      definitions: {}
    }
  }
end
