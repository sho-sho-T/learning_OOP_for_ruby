module Schedulable
  # schedule=メソッドを定義し、@scheduleインスタンス変数に値を設定できるようにする
  attr_writer :schedule

  def schedule
    @schedule ||= ::Schedule.new # 遅延初期化：@scheduleが未設定の場合、新しいScheduleオブジェクトを生成
  end

  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  def scheduled(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  # 必要に応じてインクルードする側で置き換える
  def lead_days
    0
  end
end
