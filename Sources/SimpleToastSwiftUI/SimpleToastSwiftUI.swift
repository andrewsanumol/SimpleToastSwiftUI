//
//  ToastView.swift
//  staffboard-iosApp
//
//  Created by Anumol Andrews on 08/07/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

// MARK: Toast View Modifier to display Error Message
@available(iOS 13.0, *)
struct ToastModifier: ViewModifier {

    @ObservedObject var state: ToastState

    // MARK: Body
    public func body(content: Content) -> some View {
        ZStack(alignment: state.config.alignment) {
            content
            if state.showToast {
                VStack {
                    switch state.toastCategory {
                    case .success:
                        Text(state.toastMessage)
                            .font(state.config.textFont)
                            .foregroundColor(Color.white)
                            .padding(state.config.textPadding)
                            .background(Color.green)
                            .cornerRadius(state.config.cornerRadius)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    case .error:
                        Text(state.toastMessage)
                            .font(state.config.textFont)
                            .foregroundColor(Color.white)
                            .padding(state.config.textPadding)
                            .background(Color.red)
                            .cornerRadius(state.config.cornerRadius)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    case .warning:
                        Text(state.toastMessage)
                            .font(state.config.textFont)
                            .foregroundColor(Color.black)
                            .padding(state.config.textPadding)
                            .background(Color.yellow.opacity(0.6))
                            .cornerRadius(state.config.cornerRadius)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    case .custom:
                        Text(state.toastMessage)
                            .font(state.config.textFont)
                            .foregroundColor(state.config.textColor)
                            .padding(state.config.textPadding)
                            .background(state.config.backgroundColor)
                            .cornerRadius(state.config.cornerRadius)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }
                    Text(state.toastMessage)
                        .font(state.config.textFont)
                        .foregroundColor(state.config.textColor)
                        .padding(state.config.textPadding)
                        .background(state.config.backgroundColor)
                        .cornerRadius(state.config.cornerRadius)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }
                .transition(.opacity)
                .opacity(state.showToast ? 1 : 0)
            }
        }
        //        .animation(state.config.animation, value: state.showToast)
    }
}

// MARK: ViewModifier Extension
@available(iOS 13.0, *)
public extension View {
    /**
     Applies a custom `ToastModifier` to the view based on the provided `ToastState`.
     This function extends `View` and allows the view to display a toast message
     corresponding to the given state.
     - Parameter state: The `ToastState` that determines the appearance and content
     of the toast message. It could be `.success`, `.error`, or `.warning`, for example.
     - Returns: A view modified by `ToastModifier` that displays a toast message
     according to the specified state.
     */
    func toast(state: ToastState
    ) -> some View {
        self.modifier(
            ToastModifier(
                state: state
            )
        )
    }
}


