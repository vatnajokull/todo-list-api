RSpec.describe Task, type: :model do
  context 'Structure' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:done).of_type(:boolean) }
    it { is_expected.to have_db_column(:due_date).of_type(:datetime) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:project) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'with task that were created earlier and does not have due-date' do
    it 'should raise an error in due_date validation' do
      project = create(:project)
      task = create(:task, project_id: project.id)
      task.due_date = Time.zone.now - 2.days

      expect(task).to be_invalid
      expect(task.errors[:due_date].size).to eq(1)
      expect(task.errors[:due_date][0]).to eq('can not be in the past')
    end
  end

  context 'with task that were created earlier and have due-date in the past' do
    it 'should be updated without calls due_date validation' do
      project = create(:project)
      outdated_task = create(:task, :with_due_date_in_past, project_id: project.id)

      expect { outdated_task.update(name: FFaker::HipsterIpsum.sentence) }.to change { outdated_task.name }
    end
  end
end
