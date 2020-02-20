# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
Bundler.require(*Rails.groups)

module AccountManagement
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true

    config.generators.system_tests = nil
    config.generators do |g|
      g.test_framework :rspec, view_specs: false,
                               controller_specs: false,
                               helper_specs: false,
                               routing_specs: false,
                               request_specs: false
    end
  end
end
