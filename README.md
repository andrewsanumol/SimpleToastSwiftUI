##Installation

Swift Package Manager

Go to File | Swift Packages | Add Package Dependency... in Xcode and search for "SimpleToastSwiftUI". If multiple results are found, give below url and search.
"https://github.com/andrewsanumol/SimpleToastSwiftUI"



##Usage

``` Swift

struct Toast: Equatable {
  var message: String
  var showToast:Bool = false
  var duration: Double = 3
  var width: Double = .infinity
}

struct DemoMessageView: View {
  @State private var toastInfo: Toast? = nil

    var body: some View {
        VStack(alignment: .leading) {
            Text("sample view")
        }
    }.toast(isShowing: $toastInfo.showToast, message: toastInfo.message)
    }
```

