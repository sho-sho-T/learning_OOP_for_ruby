# 旅行の準備はより簡単になる
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each {|preparer|
      preparer.prepare_trip(self)
    }
  end
end

# 全ての準備者(Preparer)は 'prepare_trip'に応答するダック
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each {|bicycle|
      prepare_bicycle(bicycle)
    }
  end
  # ......
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end
  # .....
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end
  # .....
end

# 使用例
trip = Trip.new
mechanic = Mechanic.new
coordinator = TripCoordinator.new
driver = Driver.new
trip.prepare([mechanic, coordinator, driver])

# --------------------- オブジェクト指向設計ポイント ------------------------------

# このコードの主な改善点と特徴：

# 1. 単一責任の原則の遵守：
#    各クラス（Trip, Mechanic, TripCoordinator, Driver）が明確に定義された
#    単一の責任を持っている。

# 2. 開放閉鎖の原則の遵守：
#    Trip クラスの prepare メソッドは、新しい種類の preparer を追加しても
#    修正する必要がない。拡張に対して開かれ、修正に対して閉じている。

# 3. 依存性の逆転：
#    Trip クラスは具体的な preparer クラスに依存せず、prepare_trip メソッドを
#    持つインターフェース（ダックタイピング）に依存している。

# 4. ポリモーフィズムの活用：
#    各 preparer クラスが prepare_trip メソッドを実装することで、
#    ポリモーフィックな振る舞いを実現している。
#    ポリモーフィズムとは：多岐にわたるオブジェクトが、同じメッセージに応答できる能力をさす

# 5. 柔軟性の向上：
#    新しい preparer クラスの追加が容易で、Trip クラスの変更なしに
#    システムを拡張できる。

# 6. デメテルの法則の遵守：
#    各オブジェクトは直接関係のあるオブジェクトとのみやり取りしている。
#    Trip は preparer に自身を渡し、詳細は preparer に任せている。

# 7. インターフェースの一貫性：
#    全ての preparer クラスが同じインターフェース（prepare_trip メソッド）を
#    実装している。これにより、一貫した方法で preparer を扱える。

# 8. 関心の分離：
#    Trip クラスは旅行の準備プロセスを調整する役割に集中し、
#    具体的な準備作業は各 preparer クラスに委ねている。

# 9. ダックタイピングの活用：
#    Ruby の動的型付けを活かし、明示的なインターフェース宣言なしに
#    ポリモーフィズムを実現している。

# 10. 疎結合：
#     Trip クラスと各 preparer クラスの間の結合度が低く、
#     一方の変更が他方に与える影響が最小限に抑えられている。

# この設計により、システムの保守性、拡張性、柔軟性が大幅に向上している。
# 新しい種類の preparer を追加する際も、Trip クラスを変更することなく、
# 簡単にシステムに統合できる。

# ---------------------------------------------------------------------------

# ------------------------ ダックタイピング -------------------------------------
# ダックタイピングの特徴：

# 型チェックの欠如:
#   Trip クラスの prepare メソッドは、preparers の各要素の具体的な型をチェックしている
# 共通インターフェースの想定:
#   各 preparer オブジェクトが prepare_trip メソッドを持っていることを前提としている
# 多様なオブジェクトの受け入れ:
#   Mechanic, TripCoordinator, Driver など、異なるクラスのオブジェクトが preparers 配列に含まれていても問題ない
# 振る舞いに基づく処理:
#   オブジェクトの型ではなく、prepare_trip メソッドを持つという振る舞いに基づいて処理している


# mechanic, coordinator, driverは異なるクラスのインスタンスだが、全てがprepare_tripメソッドを実装しているため、
# Tripクラスは型を気にすることなく、これらのオブジェクトを同じように扱える
# ----------------------------------------------------------------------------