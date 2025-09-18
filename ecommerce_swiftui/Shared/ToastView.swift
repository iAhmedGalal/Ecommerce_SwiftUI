//
//  ToastView.swift
//  ecommerce_swiftui
//
//  Created by Mahmoud Elzaiady on 18/09/2025.
//

import Foundation
import SwiftUI

struct Toast: Equatable {
  var style: ToastStyle
  var message: String
  var duration: Double = 3
  var width: Double = .infinity
}

enum ToastStyle {
  case error
  case warning
  case success
  case info
}

extension ToastStyle {
  var themeColor: Color {
    switch self {
    case .error: return Color.red
    case .warning: return Color.orange
    case .info: return Color.blue
    case .success: return Color.green
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

struct ToastView: View {
     var message: String
     var style: ToastStyle
     var onCancelTapped: (() -> Void)
     var body: some View {
         VStack(alignment: .leading) {
             HStack(alignment: .top) {
                 Image(systemName: style.iconFileName)
                     .foregroundColor(style.themeColor)
                 
                 VStack(alignment: .leading) {
                     Text(message)
                         .font(.jfFont(size: 18))
                         .foregroundColor(Color.black.opacity(0.6))
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
         .background(Color.white)
         .overlay(
             Rectangle()
                 .fill(style.themeColor)
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

struct ToastModifier: ViewModifier {
  @Binding var toast: Toast?
  @State private var workItem: DispatchWorkItem?
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(
        ZStack {
          mainToastView()
            .offset(y: 32)
        }.animation(.spring(), value: toast)
      )
      .onChange(of: toast, { oldValue, newValue in
          showToast()
      })
  }
  
  @ViewBuilder func mainToastView() -> some View {
    if let toast = toast {
      VStack {
        ToastView(
            message: toast.message,
            style: toast.style,
            onCancelTapped: {
                dismissToast()
            }
        )
        Spacer()
      }
    }
  }
  
  private func showToast() {
    guard let toast = toast else { return }
    
    UIImpactFeedbackGenerator(style: .light)
      .impactOccurred()
    
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
