require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TurboTodo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
      tag_hidden = 'hide' if instance.class.name == 'ActionView::Helpers::Tags::Label'
      "<div class=\"field_with_errors control-group error w-full #{tag_hidden}\">#{html_tag}</div>".html_safe
    end
  end
end
