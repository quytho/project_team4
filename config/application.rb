require File.expand_path("boot", __dir__)
require "csv"
require "rails/all"
Bundler.require(*Rails.groups)
module TrainingShop
  class Application < Rails::Application
    config.encoding = "utf-8"
  end
end
