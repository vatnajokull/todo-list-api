RSpec.describe ApiController, type: :controller do
  context 'Callbacks' do
    it { is_expected.to use_before_action(:authenticate_user!) }
    it { is_expected.to use_after_action(:verify_authorized) }
    it { is_expected.to use_after_action(:verify_policy_scoped) }
  end
end
