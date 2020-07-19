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
  
    var body: some View {
        
        HStack {
           /* Image("pink-Circle")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))*/
            ZStack {
           LinearGradient(gradient: Gradient(colors: [.white, .blue, .pink]),
                       startPoint: .top,
                       endPoint: .bottom)
            .mask(Text("A").font(.system(size: 30))).frame(width:30, height: 30).padding(EdgeInsets(top: 5, leading: 10, bottom:10, trailing: 0))
            
          
                Circle()
                            .stroke(LinearGradient(gradient: Gradient(colors: [.white, .blue, .pink]), startPoint: .top, endPoint: .bottom), lineWidth: 5)
                    .frame(width: 45, height: 45)
                Circle()
                                .stroke(LinearGradient(gradient: Gradient(colors: [.white, .blue, .pink]), startPoint: .top, endPoint: .bottom), lineWidth: 5)
                        .frame(width: 38, height: 38)
                
                
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

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(taskName1: "Algebra execrise 1",dueDate1: "22/16/20",importance1: "VeryHigh")
    }
}
