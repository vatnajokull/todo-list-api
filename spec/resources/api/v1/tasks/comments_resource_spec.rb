RSpec.describe Api::V1::Tasks::CommentResource, type: :resource do
  let(:comment) { build_stubbed(:comment) }

  subject { described_class.new(comment, {}) }

  it { is_expected.to have_attribute :body }
end
