RSpec.describe Api::V1::ProjectResource, type: :resource do
  let(:project) { build_stubbed(:project) }

  subject { described_class.new(project, {}) }

  it { is_expected.to have_attribute :name }
  it { is_expected.to have_one(:user) }
  it { is_expected.to have_many(:tasks) }
end
