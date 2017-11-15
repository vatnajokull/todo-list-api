RSpec.describe Task, type: :model do
  context 'Structure' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:done).of_type(:boolean) }
    it { is_expected.to have_db_column(:due_date).of_type(:datetime) }
    it { is_expected.to have_db_column(:position).of_type(:integer).with_options(default: 0) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'with task that were created earlier and does not have due-date' do
    it 'should raise an error in due_date validation' do
      project = create(:project)
      task = create(:task, project_id: project.id)
      task.due_date = Time.current - 2.days

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

  describe '.change_position' do
    before(:all) do
      project = create(:project)
      @tasks = create_list(:task, 5, project_id: project.id)
    end

    it 'should move task up (change position by -1) in the project' do
      current_task = @tasks[1]
      expect { current_task.change_position(:up) }.to change { current_task.position }.by(-1)
    end

    it 'should move task down (change position by +1) in the project' do
      current_task = @tasks[0]
      expect { current_task.change_position(:down) }.to change { current_task.position }.by(1)
    end
  end
end
