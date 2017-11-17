RSpec.describe 'Positions', type: :request do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, name: 'New task', project: project) }

  #  ------------------------------------------------------------------------------------------------------------------

  path '/tasks/{task_id}/position' do
    patch 'Change Position of Task' do
      tags 'Positions'

      parameter name: :task_id, in: :path, type: :integer
      parameter name: :position, in: :body, required: true, schema: {
        properties: {
          data: {
            properties: {
              type: { type: :string },
              attributes: {
                properties: {
                  position: { type: :integer }
                },
                required: [:position]
              }
            },
            required: [:type]
          }
        },
        required: [:data]
      }

      response '201', 'Changed Position' do
        it 'returns Task with changed Position' do |example|
          params = { data: { id: task.id, type: :positions, attributes: {
            position: 3
          } } }

          patch api_v1_task_position_path(task), params: params, headers: tokens

          expect(body).to be_json_eql response_schema(:positions, :show).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:positions, :update)
      end
    end
  end
end
