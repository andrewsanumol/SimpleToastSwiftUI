This toast implementation allows you to invoke a toast from any view within the app.
The toast can be displayed in the same view or a different view.
By default, it includes various styles to display the toast view that users can utilize.

##Installation

Swift Package Manager

Go to File | Swift Packages | Add Package Dependency... in Xcode and search for "SimpleToastSwiftUI". If multiple results are found, give below url and search.
"https://github.com/andrewsanumol/SimpleToastSwiftUI"



##Usage

Please refer to the example app used in repository.

``` Swift

import SimpleToastSwiftUI

@main
struct TestApp: App {
    @StateObject var toast = ToastState(toastOptions: ToastConfig(alignment: .bottom, category: .success))
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(toast)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var toastState: ToastState

    var body: some View {
        ZStack {
            Color.gray
            Spacer()
            ChildView()
            Spacer()
        }
        .toast(state: toastState)
    }
}

struct ChildView: View {
 @EnvironmentObject var toastState: ToastState

    var body: some View {
       VStack(spacing: 16) {
            Button {
                toastState.showToast(message: "Sample Error Toast", category: .error)
            } label: {
                Image(systemName: "swift")
				        Text("Click for Error Toast")
            }
            Button {
                toastState.showToast(message: "Sample Warning Toast", category: .warning)
            } label: {
                Image(systemName: "swift")
                Text("Click for Warning Toast")
            }
            Button {
                toastState.showToast(message: "Sample Success Toast", category: .success)
            } label: {
                Image(systemName: "swift")
                Text("Click for Success Toast")
            }
            Button {
                toastState.showToast(message: "Sample Custom Toast")
            } label: {
                Image(systemName: "swift")
                Text("Click for Custom Toast")
            }
        }
    }
    }
```

