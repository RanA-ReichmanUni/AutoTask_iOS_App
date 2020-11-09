//
//  TestTable.swift
//  ManageMyTime
//
//  Created by רן א on 02/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct TestTaskRow: View {
    
    @ObservedObject var taskViewModel:TaskViewModel
    //@EnvironmentObject var taskViewModelEnv:TaskViewModel
    var taskName:String
    var taskId:UUID?
    var heightFactor : CGFloat

    
    var fillColor:Color
    var opacity:CGFloat
    var isRepeatedActivity:Bool
     @State var change: Bool = false
    
    @State var displayItem: Bool = false
    
    @State var borderColor = Color.blue
    @State var dashCount :CGFloat = 0
    @Environment(\.colorScheme) var colorScheme
   
    @State var show=false
    var body: some View {
    GeometryReader { geometry in
      
          
                
                //.minimumScaleFactor(0.9)
                        //geometry.size.width seems to be relative to what ever exsits on the eidth axis, if it's empty, then it's all the screen width, if there something, then it's becomes relative
                        //rowHeight is as calculated above

       /* if(self.show)
          {*/
        Text(self.taskName).frame(width: geometry.size.width, height:  geometry.size.height).background(RoundedRectangle(cornerRadius: 5).fill(self.fillColor.opacity(self.colorScheme == .dark ? Double(self.opacity==0.2 ? self.opacity*0.5 : self.opacity) : Double(self.opacity)))).foregroundColor(.white).onTapGesture{
                   
                        if(self.taskId != nil && !self.isRepeatedActivity)
                        {
                        
                                  self.taskViewModel.getTask(taskId: self.taskId!)
                                print("here" ,self.taskViewModel.taskName)
                                   self.displayItem.toggle()
                                 print("here" ,self.displayItem)
                                self.borderColor=Color.init(red: 0, green: 0, blue: 102)
                                
                                    self.dashCount = 0
                        }
                      /*  else if(self.taskId != nil && self.isRepeatedActivity)
                        {
                            self.taskViewModel.getTask(taskId: self.taskId!)
                            print("here" ,self.taskViewModel.taskName)
                               self.displayItem.toggle()
                             print("here" ,self.displayItem)
                            self.borderColor=Color.init(red: 0, green: 0, blue: 102)
                            
                        }*/
            
                    }
     /*   }
          else{//DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            Spacer().onAppear{ self.show=true}
        }*/
           
            }
                    .sheet(isPresented: self.$displayItem) {
                        VStack {
                            DetailedTaskWithObj(displayItem:self.$displayItem, taskName: self.taskViewModel.taskName,importance: self.taskViewModel.importance,dueDate: self.taskViewModel.dueDate,notes: self.taskViewModel.notes, asstimatedWorkTimeHour: self.taskViewModel.asstimatedWorkTimeHour,asstimatedWorkTimeMinutes:self.taskViewModel.asstimatedWorkTimeMinutes,startTimeHour:self.taskViewModel.startTimeHour,startTimeMinutes:self.taskViewModel.startTimeMinutes,endTimeHour:self.taskViewModel.endTimeHour,endTimeMinutes:self.taskViewModel.endTimeMinutes,day:self.taskViewModel.date.day,month:self.taskViewModel.date.month,year:self.taskViewModel.date.year,taskId:self.taskViewModel.id,color:self.taskViewModel.color).animation(.spring()).onDisappear{self.borderColor=self.fillColor
                                 self.dashCount = 0
                            }
                                   
                            
                        
                    
                        }
                        
        
       
          
            
                
    }//.animation(.easeInOut(duration: 0.5))
        
    }
}

/*struct TestTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TestTaskRow(taskName:"Algebra",heightFactor: CGFloat(1.4),fillColor:Color(.systemPink))
    }
}*/




extension Animation {
    static func ripple() -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(1.5)
    }
    

}
