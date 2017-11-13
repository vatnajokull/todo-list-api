RSpec.describe ProjectPolicy do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  subject { described_class }

  permissions :show?, :create?, :update?, :destroy? do
    it 'allows access for the user' do
      expect(subject).to permit(user, project)
    end
  end

  permissions '.scope' do
    it 'returns Projects that belong to Project owner' do
      expect(ProjectPolicy::Scope.new(user, Project.all).resolve).to include(project)
    end

    it 'does not return Projects that do not belong to Project owner' do
      expect(ProjectPolicy::Scope.new(User.new, Project.all).resolve).not_to include(project)
    end
  end
end
