# frozen_string_literal: true

module TimeSleeps
  class IndexService
    def initialize user:, type:
      @user = user
      @type = type
    end

    def call
     time_sleeps = @user.time_sleeps
       .select(:id, :date, :start_time, :finish_time)
       .select('finish_time - start_time AS length_sleep')

     return time_sleeps.order(created_at: :asc) if @type == 'owner'
     time_sleeps.order('length_sleep desc')
    end
  end
end
