require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)


module HelloRails
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.default_locale = "zh-TW"
  end
end
