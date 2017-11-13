RSpec.describe User, type: :model do
  context 'Structure' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
  end

  context 'Associations' do
    it { is_expected.to have_many(:projects).dependent(:destroy) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  context 'Callbacks' do
    it '#skip_confirmation!' do
      expect_any_instance_of(User).to receive(:skip_confirmation!)

      User.new.run_callbacks :save
    end

    it '#skip_confirmation_notification!' do
      expect_any_instance_of(User).to receive(:skip_confirmation_notification!)

      User.new.run_callbacks :save
    end
  end
end
