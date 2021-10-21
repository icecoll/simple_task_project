# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Block Rails Wrap a field_with_errors div when validation failed
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  html_tag.html_safe
end
