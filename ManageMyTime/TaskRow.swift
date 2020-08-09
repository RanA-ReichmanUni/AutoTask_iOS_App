//
//  TaskRow.swift
//  ManageMyTime
//
//  Created by רן א on 29/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
    
    var taskName1 : String
    var dueDate1 : String
    var importance1 : String
    var color: Color
    var body: some View {
        
        HStack {
           /* Image("pink-Circle")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))*/
            ZStack {
           LinearGradient(gradient: Gradient(colors: [.white, color, .white]),
                       startPoint: .topTrailing,
                       endPoint: .bottom)
                
                
            //.mask(Text("A").font(.system(size: 30))).frame(width:30, height: 30).padding(EdgeInsets(top: 5, leading: 10, bottom:10, trailing: 0))
           
                
               Circle()    .stroke(LinearGradient(gradient: Gradient(colors: [.white, color, .white]), startPoint: .top, endPoint: .bottom), lineWidth: 5) .isHidden(true)
                      
                    .frame(width: 45, height: 45)
               /* Circle()
                                .stroke(LinearGradient(gradient: Gradient(colors: [.white, color, .white]), startPoint: .top, endPoint: .bottom), lineWidth: 5)
                        .frame(width: 38, height: 38)*/
                 
                
            }
            
            Text(taskName1).font(.system(size: 22)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)).frame(width: 180, height: 90)
           
         
                VStack {
                    Text(dueDate1).font(.system(size: 20))
               
            Text(importance1).font(.system(size: 20))
                }.padding(EdgeInsets(top: 0, leading: 35, bottom: 0, trailing: 15)).frame(width: 130, height: 90)
           
            Spacer()
         
        }.padding()
 
    }
}

/*struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(taskName1: "Algebra execrise 1",dueDate1: "22/16/20",importance1: "VeryHigh")
    }
}*/
extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    ///
    /// Example for complete removal:
    /// ```
    /// Text("Label")
    ///     .isHidden(true, remove: true)
    /// ```
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        modifier(HiddenModifier(isHidden: hidden, remove: remove))
    }
}


/// Creates a view modifier to show and hide a view.
///
/// Variables can be used in place so that the content can be changed dynamically.
fileprivate struct HiddenModifier: ViewModifier {

    private let isHidden: Bool
    private let remove: Bool

    init(isHidden: Bool, remove: Bool = false) {
        self.isHidden = isHidden
        self.remove = remove
    }

    func body(content: Content) -> some View {
        Group {
            if isHidden {
                if remove {
                    EmptyView()
                } else {
                    content.hidden()
                }
            } else {
                content
            }
        }
    }
}
