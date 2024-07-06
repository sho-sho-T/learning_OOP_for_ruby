# 引数の順番の依存を取り除く

# 初期化の際の引数にハッシュを使う
class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(args)
        @chainring = args[:chainring]
        @cog = args[:cog]
        @wheel = args[:wheel]
    end
# .....

end

Gear.new(
    :chainring => 52,
    :cog => 11,
    :wheel => Wheel.new(26, 1.5)).gear_inches

# -------------------- オブジェクト指向設計ポイント -----------------------
# 1. 引数の順番に依存しない初期化: ハッシュを使用することで、
#    引数の順番に依存せずにオブジェクトを初期化可能。
#    この方法は柔軟性を高め、将来的な変更に強い設計を実現。

# 2. 名前付き引数: ハッシュのキーが引数の名前となり、
#    コードの可読性と自己文書化性を向上。

# 3. オプション引数の容易な追加: 新しい引数を追加する際、
#    既存のコードに影響を与えずに拡張可能。

# 4. デフォルト値の設定が容易: 引数がない場合のデフォルト値を
#    簡単に設定可能。例: @chainring = args[:chainring] || 40

# 5. 依存オブジェクトの注入: wheelをハッシュ経由で渡すことで、
#    依存オブジェクトの注入が容易に。これにより結合度を低下させ、
#    テスタビリティを向上。

# 6. 無関係な引数の省略: 必要な引数のみを指定可能。
#    これにより、オブジェクト生成時の柔軟性が向上。

# 7. リファクタリングの容易さ: 将来的に引数を追加・削除する際、
#    既存のコードへの影響を最小限に抑えられる。

# 8. APIの安定性: クライアントコードは引数の順序変更の影響を
#    受けにくくなり、APIの安定性が向上。

# この設計は前例よりもさらに柔軟性が高く、変更に強い。
# ただし、引数の型チェックや必須引数の確認が必要な場合は
# 追加の処理が必要となる点に注意。
# また、Ruby 2.0以降では、キーワード引数を使用することで
# 同様の利点を得つつ、より明示的な引数定義が可能。
# --------------------------------------------------------------------