class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args = {})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def spares
    { tire_size: tire_size, chain: chain }.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def local_spares
    { rear_shock: rear_shock }
  end

  def default_tire_size
    '2.1'
  end
end

class RecumbentBike < Bicycle
  attr_reader :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def local_spares
    { flag: flag }
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end

bent = RecumbentBike.new(flag: 'tall and orange')
p bent.spares

# --------------------- オブジェクト指向設計の優れた点 ------------------------------

# 1. 単一責任の原則 (SRP)
#    各クラスが明確に定義された責任を持っています。Bicycleは共通の振る舞いを、
#    サブクラスは特定のタイプの自転車に特化した振る舞いを担当しています。

# 2. オープン・クローズドの原則 (OCP)
#    新しいタイプの自転車（RecumbentBike）を追加する際に、既存のコードを変更せずに
#    拡張できています。これは、継承と適切な抽象化によって実現されています。

# 3. リスコフの置換原則 (LSP)
#    すべてのサブクラスがBicycleの契約を守りつつ、独自の振る舞いを提供しています。
#    これにより、Bicycleタイプの変数に任意のサブクラスのインスタンスを安全に代入できます。

# 4. インターフェース分離の原則 (ISP)
#    各サブクラスが必要なメソッドのみをオーバーライドしています。不要なメソッドを
#    実装する必要がありません。

# 5. 依存性逆転の原則 (DIP)
#    高レベルのモジュール（Bicycle）が低レベルの詳細（具体的な自転車の種類）に
#    依存していません。代わりに、抽象（インターフェース）に依存しています。

# 6. テンプレートメソッドパターン
#    initialize, sparesメソッドがテンプレートメソッドとして機能し、
#    サブクラスでカスタマイズ可能な部分（hook）を提供しています。

# 7. フックメソッド
#    post_initialize, local_sparesがフックメソッドとして機能し、
#    サブクラスが必要に応じて特別な初期化や部品を追加できるようにしています。

# 8. スーパークラスでのデフォルト実装
#    default_chainのようなメソッドでデフォルトの実装を提供しつつ、
#    サブクラス（RecumbentBike）で必要に応じてオーバーライドできるようにしています。

# 9. 抽象メソッド
#    default_tire_sizeは抽象メソッドとして定義され、サブクラスに実装を強制しています。
#    これにより、タイプセーフなコードが実現されています。

# 10. ポリモーフィズム
#     sparesメソッドは、各サブクラスの特性を考慮しつつ、統一されたインターフェースを
#     提供しています。これにより、クライアントコードは具体的なクラスを知る必要がありません。

# 11. 適切なカプセル化
#     各クラスが自身の責任を適切にカプセル化しています。例えば、tape_colorは
#     RoadBikeにのみ存在し、他のクラスからは隠蔽されています。

# 12. コードの再利用
#     共通の振る舞いがBicycleクラスにまとめられており、コードの重複を避けています。

# 13. 拡張性
#     新しいタイプの自転車（RecumbentBike）を追加する際に、既存のコードを変更せずに
#     簡単に拡張できています。

# このコードは、オブジェクト指向設計の原則を適切に適用し、柔軟で拡張性の高い
# 設計を実現しています。新しいタイプの自転車の追加や既存の自転車の修正が容易で、
# 保守性の高いコードとなっています。
