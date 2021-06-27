# frozen_string_literal: true

class Api::V1::FollowersController < Api::BaseController
  def create
    params.require(:user_id)
    raise Api::Errors::RecordInvalid.new(422, 'Can not follow by yourself') if params[:user_id].to_i == current_user.id

    follower = User.find(params[:user_id])
    Followers::CreateService.new(user_id: current_user.id, follower_id: follower.id).call
    head :created
  end
end
