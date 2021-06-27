# frozen_string_literal: true

class Relationship < ApplicationRecord
  TYPES = {
    follower: 'follower'
  }.freeze

  validates :relationship_type, inclusion: { in: TYPES.values }
end
