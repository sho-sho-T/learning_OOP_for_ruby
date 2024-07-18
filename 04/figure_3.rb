class Trip
  def initialize(bicycles)
    @bicycles = bicycles
  end

  def prepare(prepare)
    # Tripはprepareに対して自身を渡し、準備を依頼する
    # prepare の具体的な型（Mechanicなど）を知る必要がない
    prepare.prepare_trip(self)
  end
end

class Mechanic
  def prepare_trip(trip)
    # MechanicはTripオブジェクトから必要な情報を取得する
    trip.bicycles.each { |bicycle| erepare_bicycle(bicycle) }
  end

  private

  def prepare_bicycle(bicycle)
    # 自転車の準備に関する詳細な処理
    # clean, pump tire, lubricate chan, check brakesなど
  end
end

# 使用例
bicycles = [Bicycle.new, Bicycle.new] # Bisycleクラスは省略
trip = Trip.new(bisycles)
mechanic = Mechanic.new
trip.prepare(mechanic)

# --------------------- オブジェクト指向設計ポイント ------------------------------

# このコードの主な特徴と利点：

# 1. コンテキストの独立性：Trip クラスは Mechanic クラスの存在を知らない。
#    prepare メソッドは任意の 'preparer' オブジェクトを受け入れる。

# 2. 依存性の逆転：Trip クラスは具体的なクラス（Mechanic）ではなく、
#    抽象的なインターフェース（prepare_trip メソッドを持つオブジェクト）に依存している。

# 3. 単一責任の原則：Trip クラスは旅行に関する情報を保持し、Mechanic クラスは
#    自転車の準備に関する責任を持つ。各クラスの責任が明確に分離されている。

# 4. 疎結合：Trip と Mechanic は互いの内部実装を知らない。Trip は単に prepare_trip
#    メソッドを呼び出し、Mechanic は必要な情報を Trip から取得する。

# 5. 拡張性：新しい種類の 'preparer'（例：TripCoordinator や Driver）を追加しても、
#    Trip クラスを変更する必要がない。

# 6. テスト容易性：Trip クラスのテストでは、prepare_trip メソッドを持つ
#    任意のモックオブジェクトを使用できる。

# 重要なポイント：
# - Trip は Mechanic に「何を」してほしいかを伝えるだけで、「どのように」行うかは知らない。
# - Mechanic は Trip から必要な情報を取得し、自律的に作業を行う。
# - この設計により、Trip クラスは再利用性が高く、様々なコンテキストで使用できる。
# - 「自分が何を望んでいるかを知っている」：Trip は prepare_trip を呼び出す。
# - 「あなたの担当部分をやってくれると信じている」：Mechanic の内部実装を信頼している。

# ---------------------------------------------------------------------------
