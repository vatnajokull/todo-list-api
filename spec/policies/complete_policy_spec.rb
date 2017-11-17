RSpec.describe CompletePolicy do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

  subject { described_class }

  permissions :update? do
    it 'allows access for the user' do
      expect(subject).to permit(user, task)
    end
  end
end
