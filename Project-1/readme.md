# Project-1

注意点：以下大概只有我才能看懂

Storyboard:

需要构建 NavigationController

Ctrl + Hold 连接

Controller 的属性可以勾选 `Is Initial View Controller` 给 NavigationController

`storyboard?.instantiateViewController(withIdentifier:)` 找到某个 StoryId 的 ViewController

```swift
guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
```

StoryBoard 中可能存在 NavigationController ，只有存在才能 Push。（这玩意连接之后不能自动生成？？？？

`navigationController?.pushViewController(vc, animated: true)`

ImageContoller 放在 ViewController 里，否则 navigate 的时候过度会黑屏撕裂。

把 ImageContoller 拉满整个 ViewController，之后要调整为建议的大小 （Shift+Alt+Cmd+=



PS：UIKit 是真滴烦，坑是真的多。相比 SwiftUI，UIKit 能做的也多，选择也多。



Referrence:

<https://www.hackingwithswift.com/read/1>

