# frozen_string_literal: true

class Api::V1::TimeSleepsController < Api::BaseController
  def create
    params.require([:date, :start_time, :finish_time])
    raise Api::Errors::BadRequest.new(400, 'start_time invalid')  unless Time.valid?(params[:start_time])
    raise Api::Errors::BadRequest.new(400, 'finish_time invalid') unless Time.valid?(params[:finish_time])

    TimeSleeps::CreateService.new(user: current_user, opts: params).call
    head :created
  end
end
