# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| ------------------ | ------   | -----------               |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |


### Association

- has_many :articles
- has_many :comments



## articles テーブル

| Column       | Type        | Options                        |
| ------       | ------      | -----------                    |
| country      | integer     | null: false                    |
| season       | string      | null: false                    |
| city         | string      | null: false                    |
| english_id      | string      | null: false                    |
| nice_id         | integer     | null: false                    |
| safe_id  | string      | null: false                    |
| content      | text        | null: false                    |
| user         | references  | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_many   :comments



## comments テーブル

| Column       | Type       |Options                           |
| ------       | ---------- | ------------------------------   |
| comment      | string     | null: false                      |
| user         | references | null: false, foreign_key: true   |


### Association

- belongs_to :user
- belongs_to :article

