RSpec.describe Api::V1::UserResource, type: :resource do
  let(:user) { build_stubbed(:user) }

  subject { described_class.new(user, {}) }

  it { is_expected.to have_attribute :email }
  it { is_expected.to have_many(:projects) }
end
