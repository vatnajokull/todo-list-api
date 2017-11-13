RSpec.describe 'Sign In', type: :request do
  path '/auth/sign_in' do
    post 'User authentication' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, required: true, schema: {
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %i[email password]
      }

      response '200', 'User information' do
        let(:user) { create(:user, password: 'password') }

        it 'returns User information' do |example|
          post api_v1_user_session_path, params: { email: user.email, password: 'password' }

          expect(response.headers).to include('access-token', 'token-type', 'client', 'expiry', 'uid')

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/json' => response_schema(:auth, :sign_in)
      end

      response '401', 'Invalid login credentials' do
        it 'returns an error' do |example|
          post api_v1_user_session_path, params: {}

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
