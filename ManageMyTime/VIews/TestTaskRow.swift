//
//  TestTable.swift
//  ManageMyTime
//
//  Created by רן א on 02/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TestTaskRow: View {
    @EnvironmentObject var taskViewModel:TaskViewModel
    var taskName:String
    var taskId:UUID?
    var heightFactor : CGFloat

    
    var fillColor:Color
    
     @State var change: Bool = false
    
    @State var displayItem: Bool = false
    
    var body: some View {
    GeometryReader { geometry in
        ZStack{
            VStack() {
                
                //.minimumScaleFactor(0.9)
                        //geometry.size.width seems to be relative to what ever exsits on the eidth axis, if it's empty, then it's all the screen width, if there something, then it's becomes relative
                        //rowHeight is as calculated above
                    
        
                   
                        Text(self.taskName).frame(width: geometry.size.width+8, height:  geometry.size.height).background(RoundedRectangle(cornerRadius: 5).fill(self.fillColor)).foregroundColor(.white).onTapGesture{
                            if(self.taskId != nil)
                                                       {
                                                          // self.taskViewModel.getTask(taskId: self.taskId!)
                                                           self.displayItem.toggle()
                                                       }
                        
                          
    
                                    
                    }
           
            }
                    .popover(isPresented: self.$displayItem) {
                        VStack {
                            DetailedTaskWithObj(displayItem:self.$displayItem,taskId:self.taskId!).environmentObject(self.taskViewModel)
                        }
                    }
                }
                .frame( maxWidth: .infinity, maxHeight: .infinity)
            
        
            Spacer()
                    
                Spacer()
            Spacer()
          
            
                
        }
        
    }
}

/*struct TestTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TestTaskRow(taskName:"Algebra",heightFactor: CGFloat(1.4),fillColor:Color(.systemPink))
    }
}*/


