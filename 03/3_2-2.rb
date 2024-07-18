# インスタンス変数の作成を分離する

# ex.2
# 独自に明示的に定義したwheelメソッド内で行うようにする。
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * wheel.diameter # gear_inchesメソッドが実行されるまでwheelインスタンス生成は延期される
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end

# -------------------- オブジェクト指向設計ポイント -----------------------
# 1. 遅延初期化（Lazy Initialization）: wheelメソッドで@wheelインスタンス変数を
#    遅延初期化。必要になるまでWheelオブジェクトの作成を延期。
#    メモリ使用の最適化とパフォーマンス向上に寄与。

# 2. カプセル化: attr_readerを使用してインスタンス変数へのアクセスを制御。
#    クラスの内部データを隠蔽し、外部からの直接アクセスを防止。

# 3. 単一責任の原則: GearクラスがWheelの作成も担当。
#    ただし、wheelメソッドで分離し、責任を明確化。

# 4. 依存性の管理: Wheelの作成をwheelメソッドに集中。
#    依存関係をより管理しやすく、将来の変更も容易に。

# 5. メモ化（Memoization）: ||=演算子を使用して@wheelの値をキャッシュ。
#    重複計算を避け、効率性を向上。

# 6. インターフェースの安定性: wheelメソッドにより、
#    Wheelオブジェクトの作成詳細を隠蔽。内部実装の変更に柔軟に対応可能。

# 7. テスト容易性: wheelメソッドをオーバーライドすることで、
#    テスト時に異なるWheelオブジェクトを注入可能。

# 8. 拡張性: 将来的にWheelの作成方法や種類を変更する場合、
#    wheelメソッドのみを修正すれば良い。

# この設計は前例よりも柔軟性が高く、単一責任の原則にも近い。
# ただし、GearクラスがまだWheelクラスに依存しており、
# 完全な依存性の注入には至っていない点に注意。
# --------------------------------------------------------------------
