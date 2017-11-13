RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Fuubar ------------------------------------------------------------------------------------------------------------

  config.fuubar_progress_bar_options = {
    format:         '[ %c/%C | %p%% ] [%b%i] [ %a | %e ]',
    progress_mark:  '#',
    remainder_mark: '-',
    starting_at:    10
  }

  # -------------------------------------------------------------------------------------------------------------------

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random
  config.disable_monkey_patching!

  Kernel.srand config.seed
end
