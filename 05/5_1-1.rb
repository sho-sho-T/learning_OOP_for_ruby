# 旅行の準備はさらに複雑になった。
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    end
  end
end

# TripCoordinator と Driverを追加
class TripCoordinator
  def buy_food(customers)
    # ....
  end
end

class Driver
  def gas_up(vehicle)
    # ...
  end

  def fill_water_tank(vehicle)
    # ....
  end
end

# 使用例
trip = Trip.new
mechanic = Mechanic.new
coordinator = TripCoordinator.new
driver = Driver.new
trip.prepare([mechanic, coordinator, driver])

# --------------------- オブジェクト指向設計ポイント ------------------------------

# このコードの主な問題点：

# 1. 単一責任の原則違反：
#    Trip クラスが、準備に関わる全ての責任を負っている。各 preparer の具体的な
#    処理内容まで Trip クラスが知っている。

# 2. 開放閉鎖の原則違反：
#    新しい種類の preparer を追加する度に、Trip クラスの prepare メソッドを
#    修正する必要がある。これは拡張に対して閉じていない。

# 3. 依存性の問題：
#    Trip クラスが Mechanic, TripCoordinator, Driver クラスに直接依存している。
#    これにより、これらのクラスの変更が Trip クラスに影響を与える。

# 4. case 文の使用：
#    ポリモーフィズムを活用せず、case 文で型チェックを行っている。これは
#    オブジェクト指向プログラミングのベストプラクティスに反する。

# 5. 柔軟性の欠如：
#    preparer の種類や処理内容が変更された場合、Trip クラスの変更が必要になる。
#    これは保守性と拡張性を低下させる。

# 6. デメテルの法則違反：
#    Trip クラスが各 preparer の具体的なメソッド（prepare_bicycles, buy_food など）を
#    直接呼び出している。これは、オブジェクト間の結合度を高める。

# 7. インターフェースの一貫性がない：
#    各 preparer クラスが異なるインターフェース（メソッド名）を持っている。
#    これは、統一されたインターフェースを通じた操作を難しくする。

# 改善のポイント：
# - 共通のインターフェース（例：prepare_trip）を持つ Preparer 抽象クラスまたは
#   モジュールを導入し、各 preparer クラスにこれを実装させる。
# - Trip クラスでは、preparer の具体的な型を知ることなく、共通インターフェースを
#   通じて prepare_trip メソッドを呼び出す。
# - これにより、新しい preparer の追加が Trip クラスの変更なしに可能になり、
#   依存性と結合度が低減される。

# ---------------------------------------------------------------------------
