# frozen_string_literal: true

module TimeSleeps
  class CreateService
    def initialize user:, opts:
      @user = user
      @opts = opts
    end

    def call
      time_sleep = @user.time_sleeps.new
      time_sleep.assign_attributes(
        date: @opts[:date],
        start_time: @opts[:start_time],
        finish_time: @opts[:finish_time],
      )

      time_sleep.save!
    end
  end
end
