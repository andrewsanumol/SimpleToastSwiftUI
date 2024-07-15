//
//  TestAppApp.swift
//  TestApp
//
//  Created by Anumol Andrews on 12/07/24.
//

import SwiftUI
import SimpleToastSwiftUI

@main
struct TestAppApp: App {
    // To set the toast config to show the toast with same configuration like //alignment, toastCategory, duration, textStyle etc. throughout the app.
    @StateObject var toast = ToastState(toastOptions: ToastConfig(alignment: .bottom, category: .custom))
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(toast)
        }
    }
}
