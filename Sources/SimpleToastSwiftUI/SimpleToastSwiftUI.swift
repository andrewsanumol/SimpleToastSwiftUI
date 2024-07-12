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

/// Configuration for displaying a toast message.
///
/// `ToastConfig` allows you to customize various aspects of a toast message,
/// such as alignment, background color, text color, text font, and animation.
public struct ToastConfig {

    /// The alignment of the toast message on the screen.
    /// This property determines where the toast message will be displayed.
    /// For example, `.top` aligns the toast message at the top of the screen.
    public var alignment: Alignment = .bottom

    /// The background color of the toast message.
    /// The default value is `Color.white`.
    public var backgroundColor: Color = Color.black

    /// The color of the text displayed in the toast message.
    /// The default value is `Color.black`. If not set, this property is optional.
    public var textColor: Color = Color.white.opacity(0.6)

    /// This property determines the roundness of the toast message's corners.
    /// The default value is `8.0`.
    public var cornerRadius: Double = 8.0

    /// The padding around the text within the toast message.
    /// This property specifies the amount of space between the text and the edges of the toast.
    /// The default value is `10.0`.
    public var textPadding: Double = 10.0

    /// The font of the text displayed in the toast message.
    /// The default value is `.subheadline`. If not set, this property is optional.
    public var textFont: Font = .subheadline

    /// The custom animation type for displaying the toast message.
    /// This property allows you to specify a custom animation for how the
    /// toast message appears and disappears. If not set, this property is optional.
    public var animation: Animation = .easeInOut

    /// The duration for which the toast message is displayed, in seconds.
    /// The default value is `2.0` seconds. If not set, the toast message will be displayed
    /// for this duration before automatically disappearing.
    public var duration: Double = 2.0

    public init(alignment: Alignment = .bottom, backgroundColor: Color = Color.white, textColor: Color = Color.black, cornerRadius: Double = 8.0, textPadding:Double = 10.0, textFont: Font = .subheadline, animation: Animation = .easeInOut(duration: 2.0)) {
        self.alignment = alignment
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.textPadding = textPadding
        self.textColor = textColor
        self.textFont = textFont
        self.animation = animation
    }
}

/// Manages the state of a toast message.
/// `ToastState` is an observable object that can be used to control the visibility
/// and content of a toast message. It provides methods to show a toast with a message
/// and optional configuration.
public class ToastState: ObservableObject {
    enum ToastCategory {
        case success
        case error
        case warning
        case custom
    }
    var toastCategory: ToastCategory = .custom
    /// Indicates whether the toast message should be shown.
    /// This property is published, so any views observing this object will be updated
    /// when the value changes.
    @Published var showToast: Bool = false

    /// The message to be displayed in the toast.
    /// This property is published, so any views observing this object will be updated
    /// when the value changes.
    var toastMessage: String = ""

    //  A published property that holds the configuration settings for the toast.
    var config: ToastConfig

    /// A state variable to hold an optional `DispatchWorkItem`.
    /// This work item can be scheduled to perform an action after a certain delay,
    /// allowing for the cancellation or rescheduling of the action if needed.
    var workItem: DispatchWorkItem?

    /**
     Schedules the dismissal of the toast after a specified duration.

     This function creates a `DispatchWorkItem` to call the `dismissToast` function,
     assigns it to `workItem`, and schedules its execution on the main queue after the
     specified duration. The duration is retrieved from a `config` object.

     - Note: The `dismissToast` function is called weakly to avoid retaining cycles.
     */
    fileprivate func scheduleToastDismissal() {
        let task = DispatchWorkItem { [weak self] in
            self?.dismissToast()
        }
        self.workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + (config.duration), execute: task)
    }

    /**
     Displays a toast with a specified message.
     This function shows a toast with the given message. If a toast is already being displayed,
     it cancels the existing dismissal task and schedules a new one. If no toast is currently
     displayed, it sets the message and shows the toast immediately, then schedules its dismissal.

     The function relies on `showToast`, `toastMessage`, and `workItem` properties,
     as well as a `scheduleDismissal` function to handle the toast's lifecycle.

     - Parameter message: The message to be displayed in the toast.
     */
    public func showToast(message: String) {
        if self.showToast {
            workItem?.cancel()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.toastMessage = message
                self.showToast = true
                self.scheduleToastDismissal()
            }
        } else {
            self.toastMessage = message
            showToast = true
            scheduleToastDismissal()
        }
    }

    /**
     Dismisses the currently displayed toast with an animation.
     This function hides the toast by setting `showToast` to `false` within an animation block.
     It also cancels any existing `DispatchWorkItem` and sets it to `nil`.
     The function ensures that the toast is dismissed smoothly and any scheduled tasks related
     to the toast are properly canceled.
     */
    private func dismissToast() {
        withAnimation() {
            showToast = false
        }
        workItem?.cancel()
        workItem = nil
    }

    /// Shows the toast with the specified message and configuration.
    /// - Parameters:
    ///   - message: The message to display in the toast.
    ///   - toastConfig: The configuration for the toast's appearance and behavior.
    public func showToast(message: String, duration: Double = 2.0) {
        self.toastMessage = message
        showToast = true
    }

    public init(toastOptions: ToastConfig) {
        self.config = toastOptions
    }
}

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


