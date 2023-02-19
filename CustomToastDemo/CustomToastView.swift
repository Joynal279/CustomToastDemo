//
//  CustomToastView.swift
//  CustomToastDemo
//
//  Created by Joynal Abedin on 19/2/23.
//

import SwiftUI

//MARK: - Custom Toast View
struct CustomToastView: View {
    
    var type: CustomToastStyle
    var title: String
    var message: String
    var onCancelTapped: (() -> Void)
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: type.iconFileName)
                    .foregroundColor(Color.white)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                    //
                    //                        Text(message)
                    //                            .font(.system(size: 12))
                    //                            .foregroundColor(Color.black.opacity(0.6))
                }
                
                Spacer(minLength: 10)
                
                Button {
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                }
            }
            .padding()
        }
        .background(type.themeColor)
        .overlay(
            Rectangle()
                .fill(type.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
    
}

//MARK: - Enum Model
struct CustomToast: Equatable {
    var type: CustomToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}

//MARK: - Enum
enum CustomToastStyle {
    case error
    case warning
    case success
    case info
}

extension CustomToastStyle {
    var themeColor: Color {
        switch self {
        case .error:
            return Color.red
        case .warning:
            return Color.orange
        case .success:
            return Color.blue
        case .info:
            return Color.green
        }
    }
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

//MARK: - Custom Toast Modifier
struct CustomToastModifier: ViewModifier {
    @Binding var toast: CustomToast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                CustomToastView(
                    type: toast.type,
                    title: toast.title,
                    message: toast.message) {
                        dismissToast()
                    }
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

//MARK: - View Extension
extension View {
    func toastView(toast: Binding<CustomToast?>) -> some View {
        self.modifier(CustomToastModifier(toast: toast))
    }
}

//MARK: - Preview
struct CustomToastView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomToastView(type: .error, title: "Error", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
            
            CustomToastView(type: .info, title: "Info", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
            CustomToastView(type: .success, title: "Success", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
            CustomToastView(type: .warning, title: "Warning", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
        }
    }
}

