# frozen_string_literal: true

class Api::V1::FollowersController < Api::BaseController
  def index
    following = current_user.following

    render json: following, status: :ok
  end

  def create
    params.require(:user_id)
    raise Api::Errors::RecordInvalid.new(422, 'Can not follow by yourself') if params[:user_id].to_i == current_user.id

    follower = User.find(params[:user_id])
    Followers::CreateService.new(user_id: current_user.id, follower_id: follower.id).call
    head :created
  end

  def destroy
    relationship = Relationship.find_by!(
      user_id: current_user.id,
      user_relationship_id: params[:user_id],
      relationship_type: Relationship::TYPES[:follower]
    )
    relationship.destroy!

    head :no_content
  end
end
