RSpec.describe 'Tasks', type: :request do
  let(:user) { create(:user) }
  let(:tokens) { user.create_new_auth_token }
  let(:project) { create(:project, user: user) }

  #  ------------------------------------------------------------------------------------------------------------------

  path '/projects/{project_id}/tasks' do
    get 'A list of Tasks' do
      tags 'Tasks'

      parameter name: :project_id, in: :path, type: :integer

      response '200', 'A list of Tasks' do
        let!(:task_one) { create(:task, name: 'Task name', project: project) }
        let!(:task_two) { create(:task) }

        it 'returns a list of Tasks' do |example|
          get api_v1_project_tasks_path(project), headers: tokens

          expect(body).to be_json_eql response_schema(:tasks, :index).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:tasks, :index)
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/projects/{project_id}/tasks' do
    post 'Creates a Task' do
      tags 'Tasks'

      parameter name: :project_id, in: :path, type: :integer
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

      response '201', 'Created Task' do
        it 'returns created Task' do |example|
          params = { data: { type: :tasks, attributes: { name: 'Task name' } } }

          post api_v1_project_tasks_path(project), params: params, headers: tokens

          expect(body).to be_json_eql response_schema(:tasks, :create).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:tasks, :create)
      end

      response '422', 'Validation errors' do
        it 'returns an error' do |example|
          params = { data: { type: :tasks, attributes: { name: '' } } }

          post api_v1_project_tasks_path(project), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/tasks/{task_id}' do
    get 'Shows the Task' do
      tags 'Tasks'

      parameter name: :task_id, in: :path, type: :integer

      response '200', 'Shows the Task' do
        let(:task) { create(:task, name: 'Task name', project: project) }

        it 'return the Task' do |example|
          get api_v1_task_path(task), headers: tokens

          expect(body).to be_json_eql response_schema(:tasks, :show).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:tasks, :show)
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/tasks/{task_id}' do
    patch 'Updates the Task' do
      tags 'Tasks'

      parameter name: :task_id, in: :path, type: :integer
      parameter name: :body, in: :body, required: true, schema: {
        properties: {
          data: {
            properties: {
              id: { type: :string },
              type: { type: :string },
              attributes: {
                properties: {
                  name: { type: :string },
                  due_date: { type: :string }
                },
                required: [:name]
              }
            },
            required: %i[id type]
          }
        },
        required: [:data]
      }

      let(:task) { create(:task, project: project) }

      response '201', 'Updated Task' do
        it 'returns updated Task' do |example|
          params = { data: { id: task.id, type: :tasks, attributes: { name: 'New task name', 'due-date': '2099-12-31T23:59:59+02:00' } } }

          patch api_v1_task_path(task), params: params, headers: tokens

          expect(body).to be_json_eql response_schema(:tasks, :update_with_due_date).to_json

          assert_response_matches_metadata(example.metadata)
        end

        examples 'application/vnd.api+json' => response_schema(:tasks, :update_with_due_date)
      end

      response '422', 'Validation errors' do
        it 'returns an error if name is empty' do |example|
          params = { data: { id: task.id, type: :tasks, attributes: { name: '' } } }

          patch api_v1_task_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end

        it 'returns an error if due_date in the past' do |example|
          params = { data: { id: task.id, type: :tasks, attributes: { name: 'New name', 'due-date': '1999-12-31T23:59:59+02:00' } } }

          patch api_v1_task_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end

  #  ------------------------------------------------------------------------------------------------------------------

  path '/tasks/{task_id}' do
    delete 'Deletes the Task' do
      tags 'Tasks'

      parameter name: :task_id, in: :path, type: :integer

      response '204', 'Returns nothing' do
        let(:task) { create(:task, project: project) }

        it 'deletes the Task' do |example|
          params = { data: { id: task.id, type: :projects } }

          delete api_v1_task_path(task), params: params, headers: tokens

          assert_response_matches_metadata(example.metadata)
        end
      end
    end
  end
end
