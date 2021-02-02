# Project-6

reference: <https://www.hackingwithswift.com/read/7> 

UITableViewCell 类型：比如带箭头 改 Accessory 可以在 StoryBoard 直接改。也可以用代码改。

```swift
cell.accessoryType = .disclosureIndicator
```

**UITableView 的上拉刷新。**

在 UITableView 上挂载 UIRefreshControl。

```swift
let rc = UIRefreshControl()
rc.addTarget(self, action: #selector(loadData), for: .valueChanged)
tableView.refreshControl = rc
```

**Navigator 传递数据**

在 Controller class 内定义初始化属性即可。

```swift
class DetailViewController: UIViewController {
    var detailItem: Petition?
  
  override func viewDidLoad() { 
    // use detailItem
    guard let detailItem = detailItem else { return }
  // ...
  }
}

// in other Controller
let vc = DetailViewController()
vc.detailItem = petitions[indexPath.row]
navigationController?.pushViewController(vc, animated: true)

```

**JSON 与 Request**

1. use `Data(contentsOf: URL)` (do simple `GET`, sync)
2. use `URLSession.shared.dataTask(with:)` (do any request, async)



1. Plain Get

```swift
// declare model

struct Post : Codable {
    var title: String
    
}

struct Posts: Codable {
    var data: [Post]
}

// use Data(contentsOf:)
let jsonUrl = URL(string: "https://api.innei.ren/v1/posts")!
let data = try? Data(contentsOf: jsonUrl)
let decoder = JSONDecoder()
let model  = try? decoder.decode(Posts.self, from: data!)
// use dataTask

let task = URLSession.shared.dataTask(with: jsonUrl) {data,_,_ in 
    guard let data = data else {return}
    let decoder = JSONDecoder()
    
    guard let model = try? decoder.decode(Posts.self, from: data) else {return}
    print(model)
}
```

2. Get with QueryParams

   1. Convert URL to URLComponents
   1. Use URLRequest

```swift
   if let component = URLComponents(string: jsonUrl.absoluteString) {
       var c = component
       c.queryItems = [URLQueryItem(name: "page", value: "2"), URLQueryItem(name: "size", value: "2")]
       
       if let url = c.url {
           print(url)
           let task = URLSession.shared.dataTask(with: url) { data, response, err in
               print(err, response)
               print(data)
               guard let data = data else {return }
               try? decoder.decode(Posts.self, from: data)
           }
           task.resume()
       }
```

   **PS**: Don't forget `resmue()` dataTask after declare methods

3. POST with application/json
   1. Declare Codable Struct Encode with `JSONEncoder`
   2. Raw String

```swift
// declare URLRequest

var request = URLRequest(url: URL(string: "http://127.0.0.1:2222")!)
request.httpMethod = "POST"
request.addValue("application/json", forHTTPHeaderField: "content-type")

// use struct
struct PostSomeData: Codable {
    var name: String;
    var age: Int
}

let postData = PostSomeData(name: "Innei", age: 20)
let encoder = JSONEncoder()
let body = try? encoder.encode(postData)
request.httpBody = body

// use raw string
request.httpBody = Data("""
    {"a": 1}
    """.utf8)
// use String.utf8 or other encoding, convert String to Data
// with URLRequest
URLSession.shared.dataTask(with: request) { data, _ ,_ in 
    let str = String(data: data!, encoding: .utf8)
    print(str)
}.resume()
                        
```

4. With Error Handing

   In default, HTTP exception status code, like (400, 422, 500), not catched in dataTask. So `error` param in onCompletion callback excluding HTTP Error. If request status is 400 and request is OK, `error` is `nil`.

   ```swift
   var errorRequest = URLRequest(url: URL(string: "http://127.0.0.1:2222")!)
   errorRequest.httpMethod = "GET"
   URLSession.shared.dataTask(with: errorRequest) { data, response, err in
       
       if let httpResponse = response as? HTTPURLResponse {
           
           guard (200...399).contains(httpResponse.statusCode) else {
             // DO ERROR HANDLING
               print("statusCode: \(httpResponse.statusCode)")
               return 
           }
           
       }
       
       
   }.resume()
   ```

   

**PS**: 为什么写着写着突然写起了蹩脚英语，主要是不想换输入法。