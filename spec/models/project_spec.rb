RSpec.describe Project, type: :model do
  context 'Structure' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
