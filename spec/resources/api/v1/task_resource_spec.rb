RSpec.describe Api::V1::TaskResource, type: :resource do
  let(:task) { build_stubbed(:task) }

  subject { described_class.new(task, {}) }

  it { is_expected.to have_attribute :name }
end
