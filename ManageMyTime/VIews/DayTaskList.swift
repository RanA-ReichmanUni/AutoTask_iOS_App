//
//  TaskList.swift
//  ManageMyTime
//
//  Created by רן א on 29/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI


struct DayTaskList: View {
    
    //var taskData : Task
   // var taskViewModel = TaskViewModel()
    
    
    @ObservedObject var taskViewModel=TaskViewModel()//previously it was @EnvironmentObject
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var offset: CGFloat = 0
     @State private var padding: CGFloat = 0
    var allTasks:[Task]
    var helper = HelperFuncs()
    var dayOfTheWeek:String
    var body: some View {

  
        
        
            ScrollView{
                           
               ZStack{
                   
                   HStack{
                    
                       Text(dayOfTheWeek).font(Font.custom("Chalkduster", size: 30)).fontWeight(.bold).font(.title).padding(EdgeInsets(top: -100, leading: 5, bottom: 0, trailing: 0))
                     //  Divider().foregroundColor(taskViewModel.getTaskColor(task: allTasks[0])).frame(height:10).background(taskViewModel.getTaskColor(task: allTasks[0]))
                     Spacer()
                   }
                    Spacer()
                   RoundedRectangle(cornerRadius: 20).isHidden(true).frame(height:400)
                   //Keeps safe space from the edge of screen so the first card can pull up to a safe area
               }
               
                      
                        
            ScrollView{
               
                   
                ForEach(allTasks, id: \.self) { task in
                    VStack{
             
                 
                            
                            
                            if(self.allTasks.firstIndex(of: task) != self.allTasks.count-1)
                             {
                                 CardTaskRow( taskViewModel:self.taskViewModel,taskId:task.id,taskName1: task.taskName, dueDate1: self.helper.dateToString(date: task.dueDate), importance1: task.importance!, workTimeHour: task.asstimatedWorkTime.hour, workTimeMinutes: task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes, scheduledDate: self.helper.dateToString(date: task.date), color: self.taskViewModel.getTaskColor(task:task),offset:self.$offset,date:task.date,notes:task.notes!,id:task.id,dueDate:task.dueDate,completed:task.completed,internalId:task.internalId!,isClickable:true).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -200, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}
                             }
                             else{
                             
                                CardTaskRow( taskViewModel:self.taskViewModel,taskId:task.id,taskName1: task.taskName, dueDate1: self.helper.dateToString(date: task.dueDate), importance1: task.importance!, workTimeHour: task.asstimatedWorkTime.hour, workTimeMinutes: task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes, scheduledDate: self.helper.dateToString(date: task.date), color: self.taskViewModel.getTaskColor(task:task),offset:self.$offset,date:task.date,notes:task.notes!,id:task.id,dueDate:task.dueDate,completed:task.completed,internalId:task.internalId!,isClickable:false).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -200, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}
                                
                             
                            }
                     
                        /*.onTapGesture {
                                withAnimation(.easeIn(duration: 5)) { self.offset = 50 }
                            }*/
                            
                            
                                  
                                   /*.padding(.top, -6)
                                   .padding(.bottom, -6)
                                   .padding(.leading, -18)
                                   .padding(.trailing, -18)*/
                           /* TaskRow(taskName1: task.taskName , dueDate1: self.helper.dateToString(date: task.dueDate) , importance1: task.importance!,color:self.taskViewModel.getTaskColor(task:task))*/
                       // }
                        
                     
                        }.padding(.bottom,40)
                             
                }
                
             
                //.navigationBarTitle(Text("Active Tasks").foregroundColor(.green))
                        
                        
                        /*Button(action: {
                                           
                                self.taskViewModel.retrieveAllTasks()
                                                    
                                                                     
                                    }) {
                                            Text("Retrieve")
                                        }*/
                
            }.background(Color.blue)
        }
        /*.onAppear{//self.taskViewModel.retrieveAllTasks()
               // self.taskViewModel.getFirstTaskColor()  //also after clicking the delete button
            }*//*.background(    LinearGradient(
            gradient: Gradient(colors: [Color(hex:"#00d2ff"),Color(hex:"#3a7bd5")]),/*.white,self.color,self.color,self.color //.white,self.color,self.color,self.color,.white*/
                     //self.color,.purple,.purple,.purple
                          startPoint: .bottomLeading,
                                   endPoint:.bottomTrailing
                    ))*/
            
         //.background(Color(hex:"#fcfcfc"))
        
       
        
    }
}


/*struct TaskList_Previews: PreviewProvider {
    
      @ObservedObject var taskViewModel = TaskViewModel()
    
    static var previews: some View {

        TaskList(taskViewModel:taskViewModel)
    }
}
*/


extension Color {
    static func random() -> Color {
        return Color(
           red:   Double.random(),
           green: Double.random(),
           blue:  Double.random()
        )
    }
}


extension Double {
    static func random() -> Double {
        return Double(arc4random()) / Double(UInt32.max)
    }
}
