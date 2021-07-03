# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, uniqueness: true
  has_many :access_tokens,
            class_name: 'Doorkeeper::AccessToken',
            foreign_key: :resource_owner_id,
            dependent: :delete_all # or :destroy if you need callbacks
  has_many :time_sleeps, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :following, source: :user, through: :relationships
end
