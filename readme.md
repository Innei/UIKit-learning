# Project-2

以下内容我随便写写

初始的 UIViewController 可以直接 Embed in UINavigationController

UIView 之间可以 Control + Drag 的方式在各个 View 之间设置相对位置，居中之类的

UIButton 通过连接的方式可以设置 onTap。直接 Drag 到连接函数。

多个 UIButton 连接同一个函数，可以通过设置每个 UIButton 的 tag 区分。

```swift
@IBAction func buttonTapped(_ sender: UIButton) {
  var title: String

  if sender.tag == correctAnswer {
    title = "Correct"
    score += 1
  } else {
    title = "Wrong"
    score -= 1
  }
}
```

UIAlartController 使用

```swift
let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
present(ac, animated: true)
```


# Referrence

<https://www.hackingwithswift.com/read/2>
