# SubscMemo

## エラーとその対処法

### unable to load standard library for target 'x86_64-apple-macosx10.15'

（原因）
R.swiftをmintで実行した際に生じた。  
macOS 向けにビルドしようとしているのに、利用するSDKがiOSシミュレーター用になっているため生じていた。

（対応）
`xcrun --sdk macosx mint run` として明示的にmacOSを指定した。

## Firebase セキュリティルール

ユーザー

|  パス名  | /user_profile/v1/users/{uid}                                 |
| :------: | ------------------------------------------------------------ |
|  `read`  | Authenticationにより付与された自身の`uid`の値と一致するドキュメントのみ許可 |
| `create` | Authenticationにより付与された自身の`uid`の値と一致するドキュメントのみ許可 |
| `update` | Authenticationにより付与された自身の`uid`の値と一致するドキュメントのみ許可 |
| `delete` | 許可しない。                                                 |

ユーザーが保存しているサブスクサービス

|  パス名  | /user_profile/v1/users/{uid}/subscription_services/{id}   |
| :------: | --------------------------------------------------------- |
|  `read`  | Authenticationにより付与された自身の`uid`配下の場合は許可 |
| `create` | Authenticationにより付与された自身の`uid`配下の場合は許可 |
| `update` | Authenticationにより付与された自身の`uid`配下の場合は許可 |
| `delete` | Authenticationにより付与された自身の`uid`配下の場合は許可 |

ユーザーが保存しているサブスクサービス（自身が独自で追加したもの）

|  パス名  | /user_profile/v1/users/{uid}/original_subscription_services/{id} |
| :------: | ------------------------------------------------------------ |
|  `read`  | Authenticationにより付与された自身の`uid`配下のドキュメントは許可 |
| `create` | Authenticationにより付与された自身の`uid`の値と一致するドキュメントのみ許可 |
| `update` | Authenticationにより付与された自身の`uid`の値と一致するドキュメントのみ許可 |
| `delete` | Authenticationにより付与された自身の`uid`配下の場合は許可    |

既存のサブスクサービス

|  パス名  | /subscription_services/v1/services/{id} |
| :------: | --------------------------------------- |
|  `read`  | 誰でも参照可能                          |
| `create` | 許可しない                              |
| `update` | 許可しない                              |
| `delete` | 許可しない                              |

サブスクサービスのカテゴリー

|  パス名  | /subscription_services/v1/categories/{id} |
| :------: | ----------------------------------------- |
|  `read`  | 誰でも参照可能                            |
| `create` | 許可しない                                |
| `update` | 許可しない                                |
| `delete` | 許可しない                                |


