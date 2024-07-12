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
    @StateObject var toast = ToastState(toastOptions: ToastConfig(alignment: .bottom, category: .custom))
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(toast)
        }
    }
}
