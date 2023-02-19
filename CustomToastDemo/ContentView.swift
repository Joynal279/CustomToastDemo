//
//  ContentView.swift
//  CustomToastDemo
//
//  Created by Joynal Abedin on 19/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var toast: CustomToast? = nil
    var body: some View {
        VStack {
            Button("Info Toast") {
                toast = CustomToast(type: .info, title: "Toast info", message: "Toast message")
            }
            Button("Warning Toast") {
                toast = CustomToast(type: .warning, title: "Toast Warning", message: "Toast message")
            }
            Button("Error Toast") {
                toast = CustomToast(type: .error, title: "Toast Error", message: "Toast message")
            }
            Button("Success Toast") {
                toast = CustomToast(type: .success, title: "Toast Success", message: "Toast message")
            }
            
        }
        .toastView(toast: $toast)
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}

