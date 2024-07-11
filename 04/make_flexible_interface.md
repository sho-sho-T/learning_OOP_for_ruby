# 柔軟なインターフェースの作成

## インターフェースの理解と定義

インターフェースは、オブジェクト間の通信を定義する重要な概念だ。

### パブリックインターフェースとプライベートインターフェース

| 種類                         | 説明                                                             |
| ---------------------------- | ---------------------------------------------------------------- |
| パブリックインターフェース   | 外部から呼び出し可能なメソッド群。クラスの主要な責任を表現する。 |
| プライベートインターフェース | クラス内部でのみ使用されるメソッド群。実装の詳細を隠蔽する。     |

### 責任、依存関係、インターフェース

- 責任：クラスが果たすべき役割
- 依存関係：クラス間の関係性
- インターフェース：責任を果たし、依存関係を管理するための手段

## パブリックインターフェースの設計

### シーケンス図の活用

シーケンス図は、オブジェクト間の相互作用を時系列で表現する図だ。インターフェース設計に非常に有効なツールとなる。

#### シーケンス図の利点

1. オブジェクト間の関係性を視覚化できる
2. メッセージの流れを明確に把握できる
3. 不必要な依存関係を発見しやすい

### 設計原則

#### 1. 「どのように」ではなく「何を」を伝える

**「私は自分が何を望んでいるかを知っているし、あなたがそれをどのようにやるかも知っているよ」**

```mermaid
sequenceDiagram
    a Trip->>a Trip: bicycles
    Note over a Trip: for each bicycle
    a Trip->>+a Mechanic: clean_bicycle(bike)
    a Mechanic-->>- a Trip: 
    a Trip->>+a Mechanic: pump_bicycle(bike)
    a Mechanic-->>- a Trip: 
    a Trip->>+a Mechanic: lube_bicycle(bike)
    a Mechanic-->>- a Trip: 
    a Trip->>+a Mechanic: check_bicycle(bike)
    a Mechanic-->>- a Trip: 
```

**図 1 Trip が Mechanic にどのように Bicycle を整備するかを伝える**

Trip は Mechanic が行うことについて、詳細をいくつも知っている。
Mechanic のメソッドに変更があった場合に、Trip 側で新しいメソッドを実行するようにしないといけない。

**「私は自分が何を望んでいるかを知っていて、あなたが何をするかも知っているよ」**

```mermaid
sequenceDiagram
    a Trip->>a Trip: bicycles
    Note over a Trip: for each bicycle
    a Trip->>+a Mechanic: prepare_bicycle(bike)
    a Mechanic->>a Mechanic: clean_bicycle(bike)
    a Mechanic->>a Mechanic: pump_bicycle(bike)
    a Mechanic->>a Mechanic: lube_bicycle(bike)
    a Mechanic->>a Mechanic: check_bicycle(bike)
    a Mechanic-->>-a Trip: 
```

**図 2 Trip は Mechanic にそれぞれの Bicycle を準備するように頼む**

Trip は Mechanic にそれぞれ Bicycle を準備するように頼み、実装の詳細は Mechanic に任せている
「どのように」を知る責任は Mechanic に渡された。（Trip は Mechanic にどんな改善があろうと、正しい振る舞いを得ることができる）

**prepare_bicycle に応答できる Mechanic のようなオブジェクトを用意しなければ、Trip を再利用するのは不可能**(Trip は「常に」prepare_bicycle メッセージを自身の Mechanic へ送らないといけない)

**オブジェクトが要求するコンテキストは、オブジェクトの再利用がどれだけ難しいかに直接関係する。**

#### 2. コンテキストの独立を模索する

Trip は、コンテキスの独立を保ちながら、Mechanic と共同作業がしたい

**「私は自分が何を望んでいるかを知っているし、あなたがあなたの担当部分をやってくれると信じているよ」**

```mermaid
sequenceDiagram
    a Trip->>+a Mechanic: prepare_trip(self)
    a Mechanic->>-a Trip: bicycles
    a Trip-->>+a Mechanic: 
    a Mechanic->>a Mechanic: prepare_bicycles(bike)
    a Mechanic-->>-a Trip: 
```

**図 3 Trip が Mechanic に Trip を準備するように頼む**

Trip は Mechanic について何も知らない

Trip は Mechanic に何を望むかを伝え、self を引数として渡す。すると、Mechanic は準備が必要な Bicycle の集まり（bicycles）を得るために直ちに Trip にコールバックする。

整備士がどのようにするかは Mechanic 内に隔離されて Trip のコンテキストも削減されている

#### 3. 他のオブジェクトを信頼する

- 図１
  - 手続型。初心者がやりがち
- 図２
  - Trip は Mechanic に Bicycle を準備するように頼んでいる。
  - Trip のコンテキスト少ない
  - Mechanic パブリックインターフェースは疎結合で、再利用もしやすい
  - Trip は prepare_bicycle に応答できるオブジェクトを自身が保持していることを知っている
    - 「常に」そのオブジェクトを持ちつづける必要がある
- 図３
  - Trip は自身が Mechanic を持っていることも、知りもしなければ気にもしない
  - メッセージの受け手を信頼し、適切に振舞ってくれることを期待している
  - 不必要に他のオブジェクトの内部動作に介入しない

手放しの信頼が、オブジェクト指向設計の要。「自分が何を望んでいるかを知っていて、オブジェクトを信頼して任せる」


#### 4. メッセージを基本としたアプリケーション設計

```mermaid
sequenceDiagram
  moe Customer->>a TripFinder: suitable_trips(on_date, of_difficulty, need bile)
  a TripFinder->>+class Trip: suitable_trips(on_date, of_difficulty)
  class Trip-->>-a TripFinder: 
  a TripFinder->>+class Bicycle: suitable_bicycle(trip_date, route type)
  class Bicycle-->>-a TripFinder: 
  a TripFinder->> moe Customer: 
```

**図４ Moeが適切な旅行についてTripFinderに頼む**

適切な旅行（suitable trip）を見つける責任を、TripFinderが負っている（何がどうなれば適切な旅行になるかの知識を全て知っている）

TripFinderは、安定したパブリックインターフェースを提供し、変更しやすく乱雑な内部実装の詳細は隠している



## 良質なインターフェースの実装

1. 明示的なインターフェースの作成

   - パブリックメソッドを明確に定義し、ドキュメント化する

2. 他のパブリックインターフェースへの敬意

   - 他のクラスのパブリックインターフェースを尊重し、不必要な依存を避ける

3. プライベートインターフェースへの依存を最小限に
   - プライベートメソッドへの依存は、変更に弱いコードを生む

## デメテルの法則

デメテルの法則は、オブジェクト間の結合度を低く保つための指針だ。

### 定義

「直接の友人とだけ話すべき」という原則。

### 違反の影響

- コードの結合度が高くなる
- 変更の影響範囲が広がる

### 違反の回避方法

1. メソッドチェーンを避ける

   - 例：`a.b().c().d()` ではなく `a.get_d()`

2. 適切な責任の分配
   - 必要な情報を持つオブジェクトに適切なメソッドを配置

## まとめ

柔軟なインターフェースの設計は、シーケンス図などのツールを活用し、適切な設計原則に従うことで達成できる。デメテルの法則を意識し、オブジェクト間の不必要な結合を避けることで、保守性と拡張性の高いコードを書くことができる。
```
