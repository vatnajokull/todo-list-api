RSpec.describe TaskPolicy do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

  subject { described_class }

  permissions :update? do
    it 'allows access for the user' do
      expect(subject).to permit(user, task)
    end
  end

  permissions '.scope' do
    it 'returns Tasks that belongs to Project' do
      expect(TaskPolicy::Scope.new(user, Task.all).resolve).to include(task)
    end

    it 'does not return Tasks that do not belong to Project' do
      expect(TaskPolicy::Scope.new(User.new, Task.all).resolve).not_to include(task)
    end
  end
end
