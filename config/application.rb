require_relative 'boot'

require 'rails/all'

require "./config/main"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SevenNote
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.cache_store = :redis_store, {
	  host: "localhost",
	  port: 6379,
	  db: "cache",
	  password: "12345",
	  namespace: "cache"
	}
	config.session_store :redis_store, {
	  servers: [
	    {
	      host: "localhost",
	      port: 6379,
	      db: "session",
	      password: "12345",
	      namespace: "session"
	    },
	  ],
	  expire_after: 90.minutes,
	  key: "_#{Rails.application.class.parent_name.downcase}_session"
	}
  end
end
