class Time
  # datetime format yyyy-mm-dd HH:MM
  def self.valid? datetime
    dt = datetime.to_s.split ' '
    y, m, d = dt[0].to_s.split /[-\/]/
    return false unless Date.valid_date? y.to_i, m.to_i, d.to_i

    hr, min = dt[1].to_s.split ':'
    hr.to_s.match?(/^\d{2}+$/) && hr.to_i < 23 && min.to_s.match?(/^\d{2}+$/) && min.to_i < 23
  end
end
