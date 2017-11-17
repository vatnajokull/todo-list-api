RSpec.describe 'Complete', type: :request do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, name: 'Task name', project: project) }

  #  ------------------------------------------------------------------------------------------------------------------

  path '/tasks/{task_id}/complete' do
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

      response '201', 'Toggle Completed Task' do
        it "returns Task with changed attribute 'done'" do |example|
          params = { data: { id: task.id, type: :completes } }

          patch api_v1_task_complete_path(task), params: params, headers: tokens

          expect(body_as_json.dig(:data, :attributes, :done)).to be_truthy

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:complete, :update)
      end
    end
  end
end
