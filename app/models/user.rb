# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, uniqueness: true
  has_many :access_tokens,
            class_name: 'Doorkeeper::AccessToken',
            foreign_key: :resource_owner_id,
            dependent: :delete_all # or :destroy if you need callbacks
end
