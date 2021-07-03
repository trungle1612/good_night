# frozen_string_literal: true

module TimeSleeps
  class IndexService
    def initialize user:, type:
      @user = user
      @type = type
    end

    def call
      return owner if @type == 'owner'

      user_following
    end

    def owner
     @user.time_sleeps
          .select(:id, :date, :start_time, :finish_time)
          .order(created_at: :asc)
    end

    def user_following
      @user.time_sleeps
           .select(:id, :date, :start_time, :finish_time)
           .select('finish_time - start_time AS length_sleep')
           .where('date >=  ?', (Time.current - 7.days).to_date)
           .order('length_sleep desc')
    end
  end
end
