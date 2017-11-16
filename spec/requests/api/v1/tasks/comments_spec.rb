RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

  #  ------------------------------------------------------------------------------------------------------------------

  path '/tasks/{task_id}/comments' do
    get 'A list of Comments' do
      tags 'Comments'

      parameter name: :task_id, in: :path, type: :integer

      response '200', 'A list of Comments' do
        it 'returns a list of Comments without images' do |example|
          create(:comment, body: 'New awesome comment', task: task)

          get api_v1_task_comments_path(task), headers: tokens

          expect(body).to be_json_eql response_schema(:comments, :index).to_json

          assert_response_matches_metadata(example.metadata)
        end

        it 'returns a list of Comments with images' do |example|
          create(:comment, :with_image, task: task)

          get api_v1_task_comments_path(task), headers: tokens

          expect(body).to have_json_path('data/0/attributes/image/thumb')

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:comments, :index)
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/tasks/{task_id}/comments' do
    post 'Creates a Comment' do
      tags 'Comments'

      parameter name: :task_id, in: :path, type: :integer
      parameter name: :body, in: :body, required: true, schema: {
        properties: {
          data: {
            properties: {
              type: { type: :string },
              attributes: {
                properties: {
                  body: { type: :string }
                },
                required: [:body]
              }
            },
            required: [:type]
          }
        },
        required: [:data]
      }

      response '201', 'Created Comment' do
        it 'returns created Comment' do |example|
          params = { data: { type: :comments, attributes: {
            body: 'New awesome comment!'
          } } }

          post api_v1_task_comments_path(task), params: params, headers: tokens

          expect(body).to be_json_eql response_schema(:comments, :create).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:comments, :create)
      end

      response '422', 'Validation errors' do
        it 'returns an error' do |example|
          params = { data: { type: :comments, attributes: { body: FFaker::Lorem.paragraphs.join(', ') } } }

          post api_v1_task_comments_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/api/v1/comments/{id}' do
    delete 'Deletes the Comment' do
      tags 'Comments'

      parameter name: :id, in: :path, type: :integer

      response '204', 'Returns nothing' do
        let(:comment) { create(:comment, task: task) }

        it 'deletes the Task' do |example|
          params = { data: { id: comment.id, type: :tasks } }

          delete api_v1_comment_path(comment), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
