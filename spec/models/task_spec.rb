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
end
