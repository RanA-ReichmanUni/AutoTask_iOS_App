//
//  EmptyCell.swift
//  ManageMyTime
//
//  Created by רן א on 05/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//


import SwiftUI

struct EmptyCell: View {
    @ObservedObject var taskViewModel = TaskViewModel()
    var taskName:String
    var taskId:UUID?
    var heightFactor : CGFloat

    
    var fillColor:Color
    
     @State var change: Bool = false
    
    @State var displayItem: Bool = false
    
    var body: some View {
    GeometryReader { geometry in

            VStack() {
                
                //.minimumScaleFactor(0.9)
                        //geometry.size.width seems to be relative to what ever exsits on the eidth axis, if it's empty, then it's all the screen width, if there something, then it's becomes relative
                        //rowHeight is as calculated above
                    
        
                   
                        Text(self.taskName).frame(width: geometry.size.width+10, height:  geometry.size.height).background(RoundedRectangle(cornerRadius: 5).fill(self.fillColor)).foregroundColor(.white)
               
                
               
        
            Spacer()
                    
                Spacer()
            Spacer()
          
            
        }
        }
        
    }
}

/*struct EmptyCell_Previews: PreviewProvider {
    static var previews: some View {
        TestTaskRow(taskName:"Algebra",heightFactor: CGFloat(1.4),fillColor:Color(.systemPink))
    }
}
*/
