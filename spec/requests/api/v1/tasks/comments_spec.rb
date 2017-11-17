RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }
  let(:long_comment) { FFaker::Lorem.paragraphs(2).join }

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
                  body: { type: :string },
                  image: { type: :string, format: :binary }
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
            body: 'New awesome comment!',
            image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'images', 'sample.jpg'))
          } } }

          post api_v1_task_comments_path(task), params: params, headers: tokens

          expect(body).to have_json_path('data/attributes/body')
          expect(body).to have_json_path('data/attributes/image/thumb')

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:comments, :create)
      end

      response '422', 'Validation errors' do
        it 'returns an error' do
          params = { data: { type: :comments, attributes: {
            body: long_comment,
            image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'images', 'fake_image.png'))
          } } }

          post api_v1_task_comments_path(task), params: params, headers: tokens

          expect(body).to be_json_eql response_schema(:comments, :errors).to_json
        end
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/comments/{comment_id}' do
    delete 'Deletes the Comment' do
      tags 'Comments'

      parameter name: :comment_id, in: :path, type: :integer

      response '204', 'Returns nothing' do
        let(:comment) { create(:comment, task: task) }

        it 'deletes the Comment' do |example|
          params = { data: { id: comment.id, type: :comments } }

          delete api_v1_comment_path(comment), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
