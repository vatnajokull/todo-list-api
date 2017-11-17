RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }

  context 'Structure' do
    it { is_expected.to have_db_column(:body).of_type(:text) }
    it { is_expected.to have_db_column(:image_data).of_type(:text) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:task) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { expect(comment).to validate_length_of(:body).is_at_least(10).is_at_most(256) }
  end
end
