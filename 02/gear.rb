# 単一責任のクラスを設計する

# Gearクラスは、自転車のギアの特性を表現する
class Gear
  attr_reader :chainring, :cog, :wheel # chainring, cog, wheelの読み取り専用アクセサを定義

  # 初期化メソッド。chainring, cog, wheel（オプション）を受け取って初期化
  def initialize(chainring, cog, wheel = nil)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  # ギア比を計算するメソッド
  def ratio
    chainring / cog.to_f
  end

  # ギアインチを計算するメソッド
  def gear_inches
    ratio * wheel.diameter # wheelがnilでないことが前提
  end
end

# Wheelクラスは、ホイールの特性を表現する。
class Wheel
  attr_reader :rim, :tire # rimとtireの読み取り専用アクセサを定義

  # 初期化メソッド。rimとtireを受け取って初期化
  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  # ホイールの直径を計算して返すメソッド
  def diameter
    rim + (tire * 2)
  end

  # ホイールの円周を計算して返すメソッド
  def circumference
    diameter * Math::PI
  end
end

# GearとWheelのクラスを利用する例
wheel = Wheel.new(26, 1.5)
gear = Gear.new(52, 11, wheel)
puts gear.gear_inches # ギアインチを計算して表示

# --------------------  オブジェクト指向設計のポイント ---------------------------
# 1.	クラスの責任の分離:
# •	Gear クラスはギアの計算に関する責任を持ち、Wheel クラスはホイールの特性に関する責任を持つ。このように、各クラスが単一の責任を持つことで、コードの可読性や保守性が向上する。
# 2.	メソッドの単一責任:
# •	各メソッドは特定の機能を実行するため、メソッドの責任が明確。例えば、ratio メソッドはギア比の計算のみを行い、diameter メソッドはホイールの直径の計算のみを行う。
# 3.	依存関係の注入:
# •	Gear クラスは wheel オブジェクトを依存として受け取る。これにより、Gear クラスは Wheel クラスに強く依存せず、依存関係が明確になる。
# 4.	再利用性の向上:
# •	Gear クラスと Wheel クラスはそれぞれ独立しているため、他のコンテキストでも再利用可能。例えば、Wheel クラスは別の車両のホイールにも使用できる。
# --------------------------------------------------------------------------
