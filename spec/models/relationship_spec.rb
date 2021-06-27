require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validations' do
    it { should validate_inclusion_of(:relationship_type).in_array(Relationship::TYPES.values) }
  end
end
