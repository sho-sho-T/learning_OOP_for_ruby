require_relative 'module/schedulable'
require 'date'

class Schedule
  def scheduled?(schedulable, start_date, end_date)
    # スケジュールのロジックを実装
    false # 仮の実装
  end
end

class Vehicle
  include Schedulable

  def lead_days
    3
  end

  def scheduled?(start_date, end_date)
    # Vehicle 固有のスケジュールチェックロジック
    false # 仮の実装
  end
end

class Mechanic
  include Schedulable

  def lead_days
    4
  end

  def scheduled?(start_date, end_date)
    # Mechanic 固有のスケジュールチェックロジック
    false # 仮の実装
  end
end

starting = Date.today
ending = Date.today + 7

v = Vehicle.new
p v.schedulable?(starting, ending)

m = Mechanic.new
p m.schedulable?(starting, ending)
