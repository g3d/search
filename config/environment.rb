# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Dir[File.join(Rails.root,'lib','**','*.rb')].each { |f| load(f) }
Dir[File.join(Rails.root,'lib','**','*.treetop')].each { |f| Treetop.load(f) }