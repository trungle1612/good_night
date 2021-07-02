FactoryBot.define do
  factory :time_sleep do
    user
    date { '2021-07-02' }
    start_time { '2021-07-02 22:00' }
    finish_time { '2021-07-03 06:00' }
  end
end
