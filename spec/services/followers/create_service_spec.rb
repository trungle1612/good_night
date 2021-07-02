# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Followers::CreateService do
  describe 'Follow a user' do
    subject(:call) { described_class.new(user_id: user_1.id, follower_id: user_2.id).call }

    let(:user_1) { FactoryBot.create(:user, name: 'lorem_1') }
    let(:user_2) { FactoryBot.create(:user, name: 'lorem_2') }
    context 'when user_1 not follow user_2 yet' do
      it { expect { subject }.to change(Relationship, :count).by(1) }
    end

    context 'when user_1 followed user_2' do
      let!(:relation_ship) do
        FactoryBot.create(:relationship, user_id: user_1.id,
                          user_relationship_id: user_2.id,
                          relationship_type: Relationship::TYPES[:follower])
      end

      it 'raise an error' do
        expect{ subject }.to raise_error(Api::Errors::ResourceNotUnique)
      end
    end
  end
end
