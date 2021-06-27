# frozen_string_literal: true

module Followers
  class CreateService
    def initialize user_id:, follower_id:
      @user_id     = user_id
      @follower_id = follower_id
      @type       = Relationship::TYPES[:follower]
    end

    def call
      relationship = Relationship.find_or_initialize_by(
        user_id: @user_id,
        user_relationship_id:  @follower_id,
        relationship_type: @type
      )

      raise Api::Errors::ResourceNotUnique.new(400, 'Already followed') if relationship.persisted?
      relationship.save!
    end
  end
end
