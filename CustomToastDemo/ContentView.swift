//
//  ContentView.swift
//  CustomToastDemo
//
//  Created by Joynal Abedin on 19/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct CustomToastView_Previews: PreviewProvider {
    static var previews: some View {
        CustomToastView()
    }
}

struct CustomToastView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(Color.red)
                
                VStack(alignment: .leading) {
                    Text("Error")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                        .font(.system(size: 12))
                        .foregroundColor(Color.black.opacity(0.6))
                }
                
                Spacer(minLength: 10)
                
                Button {
                    //TODO
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                }
            }
            .padding()
        }
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(Color.red)
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

struct CustomToast: Equatable {
    var type: CustomToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}
