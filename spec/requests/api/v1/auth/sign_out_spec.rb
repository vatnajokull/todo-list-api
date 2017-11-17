RSpec.describe 'Sign Out', type: :request do
  let(:user) { create(:user, password: 'password') }
  let(:tokens) { user.create_new_auth_token }

  path '/auth/sign_out' do
    delete 'Sign out User' do
      tags 'Authentication'

      consumes 'application/json'
      produces 'application/json'

      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string

      response '200', 'User Signed out' do
        it 'Signs out User' do |example|
          delete destroy_api_v1_user_session_path, headers: tokens

          expect(body).to be_json_eql response_schema(:auth, :sign_out).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/json' => response_schema(:auth, :sign_out)
      end

      response '404', 'User was not found or was not logged in.' do
        it 'returns an error' do |example|
          delete destroy_api_v1_user_session_path, headers: {}

          expect(body).to be_json_eql response_schema(:auth, :error).to_json

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
