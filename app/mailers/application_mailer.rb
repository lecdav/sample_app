# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'lec.david@gmail.com'
  layout 'mailer'
end
