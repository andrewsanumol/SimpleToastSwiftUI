//
//  ContentView.swift
//  TestApp
//
//  Created by Anumol Andrews on 12/07/24.
//

import SwiftUI
import SimpleToastSwiftUI

struct ContentView: View {
    @EnvironmentObject var toastState: ToastState

    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            Spacer()
            ChildView()
            Spacer()
        }
        .toast(state: toastState)
    }
}

#Preview {
    ContentView()
}
