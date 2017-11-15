RSpec.describe Api::V1::CompleteResource, type: :resource do
  let(:task) { build_stubbed(:task) }

  subject { described_class.new(task, {}) }
end
