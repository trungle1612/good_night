# frozen_string_literal: true

class Api::V1::TimeSleepsController < Api::BaseController
  def index
    user = current_user
    type = 'owner'
    if params[:follower_id]
      relation_ship = Relationship.find_by!(user_id: user.id, user_relationship_id: params[:follower_id])
      user = User.find_by!(id: params[:follower_id])
      type = 'follower'
    end

    time_sleeps = TimeSleeps::IndexService.new(user: user, type: type).call

    render json: time_sleeps, status: :ok
  end

  def create
    params.require([:date, :start_time, :finish_time])
    raise Api::Errors::BadRequest.new(400, 'start_time invalid')  unless Time.valid?(params[:start_time])
    raise Api::Errors::BadRequest.new(400, 'finish_time invalid') unless Time.valid?(params[:finish_time])

    TimeSleeps::CreateService.new(user: current_user, opts: params).call
    head :created
  end
end
