RSpec.describe 'Sign Up', type: :request do
  path '/auth' do
    post 'User registration' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, required: true, schema: {
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %i[email password]
      }

      response '200', 'User information' do
        let(:params) { attributes_for(:user) }

        it 'returns User information' do |example|
          post api_v1_user_registration_path, params: params

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/json' => response_schema(:auth, :sign_up)
      end

      response '422', 'Invalid request' do
        it 'returns an error' do |example|
          post api_v1_user_registration_path, params: {}

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
