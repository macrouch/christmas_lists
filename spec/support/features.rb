RSpec.configure do |config|
  config.include Features::Helpers, type: :feature
  config.include Helpers::AjaxHelpers, type: :feature
end
