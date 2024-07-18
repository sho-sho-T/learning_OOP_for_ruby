class Trip
  def prepare(mechanic)
    @bicycles.each do |bike|
      # 問題点: Tripクラスが Mechanic の内部実装の詳細を知りすぎている
      # Mechanic クラスのインターフェースが変更されると、このコードも変更が必要になる
      mechanic.clean_bicycle(bike)
      mechanic.pump_bicycle(bike)
      mechanic.lube_bicycle(bike)
      mechanic.check_bicycle(bike)
    end
  end
end

class Mechanic
  def clean_bicycle(bike)
    # 自転車を清掃する処理
  end

  def pump_bicycle(bike)
    # タイヤに空気を入れる処理
  end

  def lube_bicycle(bike)
    # チェーンに注油する処理
  end

  def check_bicycle(bike)
    # 自転車の点検を行う処理
  end
end

# 使用例
trip = Trip.new
mechanic = Mechanic.new
trip.prepare(mechanic)

# --------------------- オブジェクト指向設計ポイント ------------------------------

# このコードの主な問題点：

# 結合度が高い：TripクラスがMechanicクラスの詳細な実装に強く依存している。
# 変更に弱い：Mechanicクラスのメソッドが変更されると、Tripクラスも修正が必要になる。
# 単一責任の原則に違反：TripクラスがMechanicの作業順序まで管理している。
# 拡張性が低い：新しい整備手順を追加する場合、Tripクラスも変更が必要になる。
# テストが困難：TripクラスのテストがMechanicクラスの実装に依存してしまう。

# これらの問題は、「どのように」ではなく「何を」を伝えるという原則に違反している。
# Tripクラスは、Mechanicクラスに自転車の整備を依頼するだけで、その詳細な手順を指示すべきではない。

# ---------------------------------------------------------------------------
