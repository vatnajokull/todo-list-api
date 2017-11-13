RSpec.describe 'Projects', type: :request do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }

  #  ------------------------------------------------------------------------------------------------------------------

  path '/projects' do
    get 'A list of Projects' do
      tags 'Projects'

      response '200', 'A list of Projects' do
        let!(:project_one) { create(:project, name: 'Project name', user: user) }
        let!(:project_two) { create(:project) }

        it 'returns a list of Projects' do |example|
          get api_v1_projects_path, headers: tokens

          expect(body).to be_json_eql response_schema(:projects, :index).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:projects, :index)
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/projects/{project_id}' do
    get 'Shows the Project' do
      tags 'Projects'

      parameter name: :project_id, in: :path, type: :integer

      response '200', 'Shows the Project' do
        let!(:project) { create(:project, name: 'Project name', user: user) }

        it 'returns Projects' do |example|
          get api_v1_project_path(project), headers: tokens

          expect(body).to be_json_eql response_schema(:projects, :show).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:projects, :show)
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/projects' do
    post 'Creates a Project' do
      tags 'Projects'

      parameter name: :body, in: :body, required: true, schema: {
        properties: {
          data: {
            properties: {
              type: { type: :string },
              attributes: {
                properties: {
                  name: { type: :string }
                },
                required: [:name]
              }
            },
            required: [:type]
          }
        },
        required: [:data]
      }

      response '201', 'Created Project' do
        it 'returns created Project' do |example|
          params = { data: { type: :projects, attributes: { name: 'Project name' } } }

          post api_v1_projects_path, params: params, headers: tokens

          expect(body).to be_json_eql response_schema(:projects, :create).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:projects, :create)
      end

      response '422', 'Validation errors' do
        it 'returns an error' do |example|
          params = { data: { type: :projects, attributes: { name: '' } } }

          post api_v1_projects_path, params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/projects/{project_id}' do
    patch 'Updates the Project' do
      tags 'Projects'

      parameter name: :project_id, in: :path, type: :integer
      parameter name: :body, in: :body, required: true, schema: {
        properties: {
          data: {
            properties: {
              id: { type: :string },
              type: { type: :string },
              attributes: {
                properties: {
                  name: { type: :string }
                },
                required: [:name]
              }
            },
            required: %i[id type]
          }
        },
        required: [:data]
      }

      let(:project) { create(:project, user: user) }

      response '201', 'Updated Project' do
        it 'returns updated Project' do |example|
          params = { data: { id: project.id, type: :projects, attributes: { name: 'New project name' } } }

          patch api_v1_project_path(project), params: params, headers: tokens

          expect(body).to be_json_eql response_schema(:projects, :update).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:projects, :update)
      end

      response '422', 'Validation errors' do
        it 'returns an error' do |example|
          params = { data: { id: project.id, type: :projects, attributes: { name: '' } } }

          patch api_v1_project_path(project), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/projects/{project_id}' do
    delete 'Deletes the Project' do
      tags 'Projects'

      parameter name: :project_id, in: :path, type: :integer

      response '204', 'Returns nothing' do
        let(:project) { create(:project, user: user) }

        it 'deletes the Project' do |example|
          params = { data: { id: project.id, type: :projects } }

          delete api_v1_project_path(project), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
