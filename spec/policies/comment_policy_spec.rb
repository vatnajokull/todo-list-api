RSpec.describe CommentPolicy do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }
  let(:comment) { create(:comment, task: task) }

  subject { described_class }

  permissions :index?, :create?, :destroy? do
    it 'allows access for the user' do
      expect(subject).to permit(user, comment)
    end
  end

  permissions '.scope' do
    it 'returns Comments that belongs to Task' do
      expect(CommentPolicy::Scope.new(user, Comment.all).resolve).to include(comment)
    end

    it 'does not return Comments that do not belong to Task' do
      expect(CommentPolicy::Scope.new(User.new, Comment.all).resolve).not_to include(comment)
    end
  end
end
