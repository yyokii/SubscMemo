# SubscMemo

This app manages subscription services.

* [About](#about)
* [Getting Started](#getting-started)
* [License](#license)

## About

### Screenshot

<img width="500" alt="スクリーンショット 2021-08-30 1 02 42" src="https://user-images.githubusercontent.com/20992687/131257125-04ab204d-d09f-4330-8def-12a5496b6506.png">

### Features

The main functions are as follows.

* Display Subscribed Services
* Display Subscribed Services Data
* Explore Services
* Push Notification
* Widget

### Architecture

![app_architecture](https://user-images.githubusercontent.com/20992687/131257015-468f9ad5-0bc4-4f6c-b0ea-bb575ceb2877.png)

## Getting Started

...

## License

This is licensed under the MIT license. See [LICENSE](https://github.com/yyokii/SubscMemo/blob/main/LICENSE) for more info.

---

## エラーとその対処法

### unable to load standard library for target 'x86_64-apple-macosx10.15'

（原因）
R.swiftをmintで実行した際に生じた。  
macOS 向けにビルドしようとしているのに、利用するSDKがiOSシミュレーター用になっているため生じていた。

（対応）
`xcrun --sdk macosx mint run` として明示的にmacOSを指定した。
