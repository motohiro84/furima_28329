# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| password           | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| first_name_reading | string | null: false |
| last_name_reading  | string | null: false |
| birthday           | data   | null: false |

### Association

- has_many :products
- has_many :orders

## products テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| image         | text       | null: false                    |
| title         | string     | null: false                    |
| text          | text       | null: false                    |
| price         | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |
| category_id   | integer    | null: false                    |
| condition     | integer    | null: false                    |
| postage       | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| shipment      | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :order
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| buildind_name | string     |                                |
| phone         | integer    | null: false                    |
| product       | references | null: false, foreign_key: true |

### Association

- belongs_to :product

## orders テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| product       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :products