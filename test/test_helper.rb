# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def setup
    @base_title = "| Ruby on Rails Tutorial Sample App"
  end

  # Return true if a test user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Log in a particular user / Be carefull, 2 versions of log_in_as!!!
  def log_in_as(user)
    session[:user_id] = user.id
  end
  
end

class ActionDispatch::IntegrationTest
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end
