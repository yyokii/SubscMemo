# SubscMemo

## エラーとその対処法

### unable to load standard library for target 'x86_64-apple-macosx10.15'

（原因）
R.swiftをmintで実行した際に生じた。  
macOS 向けにビルドしようとしているのに、利用するSDKがiOSシミュレーター用になっているため生じていた。

（対応）
`xcrun --sdk macosx mint run` として明示的にmacOSを指定した。
