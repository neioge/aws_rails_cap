ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# CLI上のテストの結果を見やすくするためのgem
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:employee_id].nil?
  end

  def log_in_as(employee)
    session[:employee_id] = employee.id
  end
  
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_as(employee, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: employee.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end

# テストにおける、ユーザーをログインさせるヘルパーはlog_in_asで統一する。統合でも単体でも、同じように使える（ダックタイピング
# 理由はわからないけど、統合テストではセッションを直接扱えないらしい。なのでポスト送信をする。