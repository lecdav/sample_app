# frozen_string_literal: true
class User < ApplicationRecord
  validates :name, presence: true, 
                   length: { minimum: 1, maximum: 50 }
  validates :email, presence: true,
                    length: { minimum: 5, maximum: 255 }
end
