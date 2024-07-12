class Trip
  def prepare(mechanic)
    @bicycles.each do |bike|
      # 改善点: Trip は Mechanic に「何を」すべきかだけを伝えている
      # Mechanic の内部実装の詳細を知る必要がない
      mechanic.prepare_bicycle(bike)
    end
  end
end

class Mechanic
  def prepare_bicycle(bike)
    clean_bicycle(bike)
    pump_bicycle(bike)
    lube_bicycle(bike)
    check_bicycle(bike)
  end

  private

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

# このコードの主な改善点：

# 1. 低結合：Trip クラスは Mechanic の内部実装詳細を知らない。
# 2. 変更に強い：Mechanic クラスの内部実装が変更されても、Trip クラスは影響を受けない。
# 3. 単一責任の原則を遵守：Trip は準備を依頼し、Mechanic は自転車の整備詳細を管理している。
# 4. 拡張性が高い：Mechanic クラスに新しい整備手順を追加しても、Trip クラスは変更不要。
# 5. テストが容易：Trip クラスのテストは Mechanic クラスのモックオブジェクトで簡単に行える。

# この設計は「どのように」ではなく「何を」を伝える原則に従っている。
# Trip クラスは Mechanic クラスに自転車の準備を依頼するだけで、その詳細な手順を知る必要がない。

# 重要なポイント：
# - prepare_bicycle に応答できる Mechanic のようなオブジェクトを用意すれば、Trip は再利用可能。
# - Trip は「常に」prepare_bicycle メッセージを Mechanic へ送るだけでよい。
# - オブジェクトが要求するコンテキスト（この場合 prepare_bicycle メソッド）が少ないほど、
#   そのオブジェクトの再利用が容易になる。

# ---------------------------------------------------------------------------