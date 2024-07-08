# 単一責任原則（SRP）

## 定義

単一責任原則は、次のように定義される：

> クラスは変更の理由を 1 つだけ持つべきである

つまり、各クラスは 1 つの明確な責任のみを持つべきという考え方だ。

## SOLID 原則との関係

単一責任原則は、SOLID 原則の「S」にあたる。SOLID 原則は以下の 5 つの設計原則の頭文字を取ったものだ：

- **S**ingle Responsibility Principle (単一責任原則)
- **O**pen-Closed Principle (開放閉鎖原則)
- **L**iskov Substitution Principle (リスコフの置換原則)
- **I**nterface Segregation Principle (インターフェース分離原則)
- **D**ependency Inversion Principle (依存性逆転の原則)

これらの原則は、より保守性が高く、拡張性のあるソフトウェアを設計するためのガイドラインとなる。

## 単一責任原則の重要性

| メリット     | 説明                                                 |
| ------------ | ---------------------------------------------------- |
| 可読性向上   | 各クラスの役割が明確になり、コードの理解が容易になる |
| 保守性向上   | 変更が必要な箇所を特定しやすく、影響範囲も限定される |
| 再利用性向上 | 単一の責任を持つクラスは、他の文脈でも使いやすい     |
| テスト容易性 | 責任が限定されているため、ユニットテストが書きやすい |

## Ruby による例

単一責任原則に違反している例：

```ruby
class User
  def initialize(name, email)
    @name = name
    @email = email
  end

  def save_to_database
    # データベース保存のロジック
  end

  def send_welcome_email
    # メール送信のロジック
  end
end
```

単一責任原則に従った例：

```ruby
class User
  attr_reader :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end
end

class UserPersistence
  def save(user)
    # データベース保存のロジック
  end
end

class UserNotifier
  def send_welcome_email(user)
    # メール送信のロジック
  end
end
```

## 適用のガイドライン

1. クラスの責任を 1 つの文で説明できるか確認する
2. クラスのメソッドが全て同じ責任に関連しているか検証する
3. 変更の理由が複数ある場合、クラスの分割を検討する

## 注意点

単一責任原則の適用には過度にならないよう注意が必要だ。過剰な分割は逆に複雑性を増す可能性がある。コンテキストと要件に応じて適切なバランスを取ることが重要だ。

## まとめ

単一責任原則は、コードの品質を向上させる重要な設計原則の 1 つだ。この原則を意識してコードを書くことで、より整理された、理解しやすい、そして保守しやすいソフトウェアを作成できる。ただし、機械的な適用ではなく、プロジェクトの特性に応じて柔軟に適用することが肝要だ。
