//
//  TaskUnitPotrait.swift
//  ManageMyTime
//
//  Created by רן א on 28/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TaskUnitPotrait: View {
    
    var taskName:String
    
    var heightFactor : CGFloat

    
    var fillColor:Color
    
     @State var change: Bool = false
    
        
    
    var body: some View {
    GeometryReader { geometry in
        VStack() {
            Text(self.taskName).frame(width: geometry.size.width*1.2, height:  geometry.size.height*1.2)
                    //geometry.size.width seems to be relative to what ever exsits on the eidth axis, if it's empty, then it's all the screen width, if there something, then it's becomes relative
                    //rowHeight is as calculated above
                    .background(RoundedRectangle(cornerRadius: 5).fill(self.fillColor)).foregroundColor(.white)
               
            }
                    
                Spacer()
            Spacer()
          
            
                
        }
        }
    }


struct TaskUnitPotrait_Previews: PreviewProvider {
    static var previews: some View {
        TestTaskRow(taskName:"Algebra",heightFactor: CGFloat(1.4),fillColor:Color(.systemPink))
    }
}

