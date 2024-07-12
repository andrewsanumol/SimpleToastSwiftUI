//
//  ChildView.swift
//  TestApp
//
//  Created by Anumol Andrews on 12/07/24.
//

import SimpleToastSwiftUI
import SwiftUI

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
