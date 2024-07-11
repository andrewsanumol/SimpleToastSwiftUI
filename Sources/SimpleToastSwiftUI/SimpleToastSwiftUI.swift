//
//  ToastView.swift
//  staffboard-iosApp
//
//  Created by Anumol Andrews on 08/07/24.
//  Copyright © 2024 orgName. All rights reserved.
//

/// To show a message as a toast
import SwiftUI

// MARK: Toast View Modifier to display Error Message
@available(iOS 13.0, *)
struct ToastModifier: ViewModifier {

    /// Used to handle visibility of the toast.
    @Binding var isShowing: Bool
    /// The message to be displayed in the toast.
    let message: String
    /// The duration the toast is shown in seconds.
    let duration: Double
    /// A state variable to hold an optional `DispatchWorkItem`.
    /// This work item can be scheduled to perform an action after a certain delay,
    /// allowing for the cancellation or rescheduling of the action if needed.
    @State private var workItem: DispatchWorkItem?
    /// State variable to control the background color of the toast
    @State private var backgroundColor = Color.yellow.opacity(0.8)

    // MARK: Body
    public func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            if isShowing {
                VStack {
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                        .onAppear {
                            workItem?.cancel()
                            let task = DispatchWorkItem {
                                dismissToast()
                            }
                            workItem = task
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
                        }
                }
                .transition(.opacity)
                .opacity(isShowing ? 1 : 0)
            }
        }
        .animation(.easeInOut(duration: 1.0), value: isShowing)
    }
    private func dismissToast() {
        withAnimation {
            isShowing = false
        }

        workItem?.cancel()
        workItem = nil
    }
}

// MARK: ViewModifier Extension
@available(iOS 13.0, *)
extension View {
    /// Toast message view
    /// - Parameters:
    ///   - isShowing: A binding variable to control the visibility of the toast.
    ///   - message: The message to be displayed in the toast.
    ///   - duration: The duration the toast is shown for, in seconds.
    /// - Returns: A view that includes the toast overlay.
    func toast(
        isShowing: Binding<Bool>,
        message: String,
        duration: Double = 2.0
    ) -> some View {
        self.modifier(
            ToastModifier(
                isShowing: isShowing,
                message: message,
                duration: duration
            )
        )
    }
}


