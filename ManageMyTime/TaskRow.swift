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
            Image("pink-Circle")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
           
            
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
