# frozen_string_literal: true

class Relationship < ApplicationRecord
  TYPES = {
    follower: 'follower'
  }.freeze
  belongs_to :user, foreign_key: :user_relationship_id 

  validates :relationship_type, inclusion: { in: TYPES.values }
end
