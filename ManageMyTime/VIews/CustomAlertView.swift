//
//  CustomAlertView.swift
//  AutoTask
//
//  Created by רן א on 16/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct CustomAlertView<Presenting>: View where Presenting: View {

    
    @Binding var isShowing: Bool
    
    let presenting: () -> Presenting
    
    var message: String
    var url: URL
    var onAcceptClicked: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            self.presenting()
                .blur(radius: self.isShowing ? 4 : 0)
                .disabled(self.isShowing)
            
            HStack {
                Spacer()
                VStack (alignment: .center) {
                    Spacer()
                        .frame(width: 0, height: 120)
                    
                    VStack (alignment: .center, spacing: 2){
                       Image(systemName: "doc")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 50, height: 60)
                       //.modifier(fillButtonCircle(foregroundColor: .white, backgroundColor: .blue, dimension: 15))
                       .offset(x: 0, y: 35)
                        
                       .zIndex(1)
                        Button(self.message){
                            UIApplication.shared.open(self.url)
                        }
                           
                        
                    }
                    VStack {
                        Button(action: self.accept){
                            Text("Accept", comment: "")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        Divider()
                            .frame(height: 1)
                        Button(action: {
                            self.isShowing.toggle()
                        }){
                            Text("cancel", comment: "")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                    }
                    .frame(maxWidth: geometry.size.width * 0.60, maxHeight: 100)
                    .background(Rectangle().foregroundColor(.white).cornerRadius(15).opacity(1))
                    .shadow(radius: 8)
                    Spacer()
                }
                Spacer()
            }
            .contentShape(Rectangle())//per far cliccare anche al centro
            //.offset(x: 0, y: -60)
            .opacity(self.isShowing ? 1 : 0)
            .onTapGesture {
                self.isShowing.toggle()
            }
        }
        
    }
    
    func accept() {
        onAcceptClicked()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            self.isShowing.toggle()
        })
        
    }
}

extension View {
    func myAlertView(isShowing: Binding<Bool>, message: String, url:URL, onAcceptClicked: @escaping () -> Void) -> some View {
        CustomAlertView(isShowing: isShowing, presenting: { self }, message: message, url: url, onAcceptClicked: onAcceptClicked)
           
    }
}
struct TestingView: View {
            
    @State var isShowing: Bool = false
    
    var body: some View {
        
          
        Button("click me") {
            self.isShowing.toggle()
        }
        .myAlertView(isShowing: $isShowing, message: "link message", url: URL(string: "https://www.google.com")!, onAcceptClicked: {
            print("Agreements accepted")
        })
           
    }

   
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
