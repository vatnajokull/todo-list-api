RSpec.describe Api::V1::TaskResource, type: :resource do
  let(:task) { build_stubbed(:task) }

  subject { described_class.new(task, {}) }

  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :done }
  it { is_expected.to have_attribute :position }
  it { is_expected.to have_attribute :comments_count }

  it { is_expected.to have_many(:comments) }
end
