require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TimlabsIo
  class Application < Rails::Application
    config.sass.preferred_syntax = :sass

    config.generators do |g|
      g.template_engine :slim
      g.test_framework :test_unit, fixture: false
    end
  end
end
