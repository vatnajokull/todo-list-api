RSpec.describe 'Complete', type: :request do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, name: 'Task name', project: project) }

  #  ------------------------------------------------------------------------------------------------------------------

  path '/tasks/{task_id}' do
    patch 'Mark Task as completed' do
      tags 'Complete'

      parameter name: :task_id, in: :path, type: :integer
      parameter name: :body, in: :body, required: true, schema: {
        properties: {
          data: {
            properties: {
              id: { type: :string },
              type: { type: :string }
            },
            required: %i[id type]
          }
        },
        required: [:data]
      }

      response '201', 'Completed Task' do
        it "returns Task with changed attribute 'done'" do |example|
          params = { data: { id: task.id, type: :tasks } }

          patch api_v1_task_path(task), params: params, headers: tokens

          expect(body).to be_json_eql response_schema(:tasks, :show).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:complete, :update)
      end
    end
  end
end
