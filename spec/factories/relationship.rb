FactoryBot.define do
  factory :relationship do
    user factory: :user
    association :user_relationship_id, factory: :user
    relationship_type { Relationship::TYPES.values.sample }
  end
end
