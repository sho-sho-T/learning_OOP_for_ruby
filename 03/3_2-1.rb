# インスタンス変数の作成を分離する

# ex.1 
# Wheelの新しいインスタンス作成を、Gearのgear_inchesメソッドからinitializeメソッドに移す

class Gear
    attr_reader :chainring, :cog, :rim, :tire
    def initialize(chainring, cog, rim, tire) # 依存はinitializeメソッドにて公開
        @chainring = chainring
        @cog = cog
        @wheel = Wheel.new(rim, tire) #Gearが作られる時に無条件でWheelも作られる
    end

    def gear_inches
        ratio * wheel.diameter
    end
    #....
end

# -------------------- オブジェクト指向設計ポイント -----------------------
# 1. カプセル化: attr_readerでインスタンス変数へのアクセスを制御。
#    クラスの内部データを隠蔽し、外部からの直接的なアクセスを防止。

# 2. 依存オブジェクトの作成: initializeメソッド内でWheelオブジェクトを作成。
#    依存オブジェクトの注入の一形態だが、Gearクラスの柔軟性を制限。

# 3. 単一責任の原則: GearクラスがWheelクラスの作成に関与。
#    単一責任の原則に反する可能性。

# 4. 結合度: gear_inchesメソッドはwheelオブジェクトに依存するが、
#    直接的な結合を回避。さらなる改善の余地あり。

# 5. インスタンス変数の初期化: すべてのインスタンス変数をinitializeメソッドで
#    初期化。オブジェクトの状態を明確化。

# 6. 依存性の注入: Wheelオブジェクトを外部から注入する方が柔軟な設計に。
#    例: initialize(chainring, cog, wheel)

# 7. インターフェースの分離: GearクラスがWheelクラスの具体的な実装に依存。
#    インターフェース使用で依存性を緩和可能。

# 8. 拡張性: 現設計ではGearクラスがWheelクラスに強く結合。
#    将来的な変更が困難。

# これらのポイントを考慮し、より柔軟で保守しやすいデザインに改善可能。
# 依存性注入やインターフェース導入で、クラス間の結合度を下げ、
# テスタビリティと再利用性を向上させる。
# --------------------------------------------------------------------