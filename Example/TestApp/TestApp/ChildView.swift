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
        ZStack {
            Button {
                toastState.showToast(message: "Sample Toast", category: .error)
            } label: {
                Image(systemName: "swift")
				Text("Click for toast")
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(.infinity)
        }
    }
}
