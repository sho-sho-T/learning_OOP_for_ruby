# 複数のパラメータを用いた初期化処理を隔離する。

# Gearが外部インターフェースの一部の場合

# ------------ 外部フレームワーク ----------------------
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end
    # ...
  end
end
# --------------------------------------------------

# 外部のインターフェースラップし、自身を変更から守る
module GearWrapper # ←責任：SomeFramework::Gearのインスタンスを作成すること
  def self.gear(args)
    SomeFramework::Gear.new(args[:chainring],
                            args[:cog],
                            args[:wheel])
  end
end

# 引数を持つハッシュを渡すことでGearのインスタンスを作成できるようなった
GearWrapper.gear(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)
).gear_inches

# -------------------- オブジェクト指向設計ポイント -----------------------
# 1. 依存関係の管理: GearWrapperモジュールが外部フレームワークとの
#    インターフェースを管理。これにより、アプリケーションコードを
#    外部の変更から保護。

# 2. アダプターパターン: GearWrapperが外部のGearクラスと
#    アプリケーションコードの間のアダプターとして機能。
#    インターフェースの不一致を解消。

# 3. 名前付き引数の使用: ハッシュを使用することで、引数の順序に
#    依存しない柔軟なインターフェースを提供。

# 4. カプセル化: 外部フレームワークの詳細をGearWrapper内に隠蔽。
#    アプリケーションコードはラッパーのみを知れば良い。

# 5. 単一責任の原則: GearWrapperは外部インターフェースの変換という
#    単一の責任を持つ。これにより、変更理由が限定される。

# 6. オープン/クローズドの原則: 新しい要件が発生した場合、
#    GearWrapperを修正するだけで対応可能。外部コードに影響を与えない。

# 7. 依存性の逆転: アプリケーションコードが直接外部フレームワークに
#    依存せず、抽象化されたインターフェース（GearWrapper）に依存。

# 8. テスト容易性: GearWrapperをモック化することで、外部フレームワークに
#    依存せずにアプリケーションコードのテストが可能。

# 9. 変更の局所化: 外部フレームワークのインターフェースが変更された場合、
#    修正はGearWrapper内に限定される。

# 10. 段階的な移行の容易さ: 既存のコードベースを徐々に新しいインターフェースに
#     移行する際に有用。古いコードと新しいコードの共存が可能。

# この設計は外部依存を効果的に管理し、アプリケーションの柔軟性と
# 保守性を向上させる。ただし、追加の抽象化層によるわずかな
# パフォーマンスオーバーヘッドが生じる可能性がある点に注意。
# --------------------------------------------------------------------
