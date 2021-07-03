# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FollowersController, type: :request do
  describe 'Follow a user' do
    subject { post '/api/v1/followers', headers: headers, params: params }

    let(:user_1) { FactoryBot.create(:user, name: 'lorem_1') }
    let(:user_2) { FactoryBot.create(:user, name: 'lorem_2') }
    let(:user_2_id) { user_2.id }
    let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: user_1.id) }
    let(:headers) { {'Authorization': "Bearer #{access_token.token}"} }
    let(:params) do
      { user_id: user_2_id }
    end

    context 'when params invalid' do
      context 'when user_id is nil' do
        let(:user_2_id) { nil }
        it_behaves_like 'bad_request'
      end

      context 'when user_id is wrong' do
        let(:user_2_id) { -999 }
        it_behaves_like 'not_found_request'
      end
    end

    context 'when user_1 followed user_2' do
      let!(:relation_ship) do
        FactoryBot.create(:relationship, user_id: user_1.id,
                          user_relationship_id: user_2.id,
                          relationship_type: Relationship::TYPES[:follower])

        it_behaves_like 'conflict_request'
      end
    end

    context 'when params valid' do
      it_behaves_like 'created_success_request'
    end
  end

  describe 'Unfollow a user' do
    subject { delete "/api/v1/followers/#{user_id}", headers: headers }

    let(:user_1) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }
    let(:user_2_id) { user_2.id }
    let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: user_1.id) }
    let(:headers) { {'Authorization': "Bearer #{access_token.token}"} }
    let(:user_id) { user_2_id }

    context 'when user_1 not follow user_2 yet' do
      it_behaves_like 'not_found_request'
    end

    context 'when user_1 followed user_2' do
      let!(:relation_ship) do
        FactoryBot.create(:relationship, user_id: user_1.id,
                          user_relationship_id: user_2.id,
                          relationship_type: Relationship::TYPES[:follower])
      end

        it_behaves_like 'no_content_request'

        it { expect { subject }.to change(Relationship, :count).by(-1) }
    end
  end
end
