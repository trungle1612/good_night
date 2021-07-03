# frozen_string_literal: true

class TimeSleepSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :finish_time, :length_sleep

  def start_time
    object.start_time.strftime('%F %H:%M')
  end

  def finish_time
    object.finish_time.strftime('%F %H:%M')
  end
end
