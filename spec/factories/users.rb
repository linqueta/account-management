# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123456' }

    after :create do |user|
      create :account, user: user
    end
  end
end
