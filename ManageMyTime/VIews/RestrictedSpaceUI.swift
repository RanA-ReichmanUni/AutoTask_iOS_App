//
//  RestrictedSpaceUI.swift
//  ManageMyTime
//
//  Created by רן א on 18/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//
//  TaskList.swift
//  ManageMyTime
//
//  Created by רן א on 29/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI


struct RestrictedSpaceUI: View {
    
    //var taskData : Task
   // var taskViewModel = TaskViewModel()
    
    
    // @ObservedObject var taskViewModel:TaskViewModel//previously it was @EnvironmentObject
    @ObservedObject var restrictedSpaceViewModel:RestrictedSpaceViewModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var offset: CGFloat = 0
     @State private var padding: CGFloat = 0
    var helper = HelperFuncs()

    var body: some View {

  
            ScrollView{
              
                ForEach(restrictedSpaceViewModel.allRestrictedSpaces, id: \.self) { restrictedSpace in
                    VStack{
                       /* NavigationLink(destination: DetailedTaskUI( taskViewModel:self.taskViewModel,taskName: restrictedSpace.taskName,importance: restrictedSpace.importance!,dueDate: restrictedSpace.dueDate,notes: restrictedSpace.notes!, asstimatedWorkTimeHour: restrictedSpace.asstimatedWorkTime.hour,asstimatedWorkTimeMinutes:restrictedSpace.asstimatedWorkTime.minutes,startTimeHour:restrictedSpace.startTime!.hour,startTimeMinutes:restrictedSpace.startTime!.minutes,endTimeHour:restrictedSpace.endTime!.hour,endTimeMinutes:restrictedSpace.endTime!.minutes,day:restrictedSpace.date.day,month:restrictedSpace.date.month,year:restrictedSpace.date.year,taskId:restrictedSpace.id,color:self.taskViewModel.getTaskColor(task:restrictedSpace)))*/
                       
                            
                        RestrictedSpaceCard(dayOfTheWeek: restrictedSpace.dayOfTheWeek,startTimeHour:restrictedSpace.startTime.hour,startTimeMinutes:restrictedSpace.startTime.minutes,endTimeHour:restrictedSpace.endTime.hour,endTimeMinutes:restrictedSpace.endTime.minutes,offset:self.$offset,id:restrictedSpace.id, color: self.restrictedSpaceViewModel.getRestrictedSpaceColor(restrictedSpace:restrictedSpace), name: restrictedSpace.name).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: 0, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}/*.onTapGesture {
                                withAnimation(.easeIn(duration: 5)) { self.offset = 50 }
                            }*/
                            
                            
                                  
                                   /*.padding(.top, -6)
                                   .padding(.bottom, -6)
                                   .padding(.leading, -18)
                                   .padding(.trailing, -18)*/
                           /* TaskRow(taskName1: task.taskName , dueDate1: self.helper.dateToString(date: task.dueDate) , importance1: task.importance!,color:self.taskViewModel.getTaskColor(task:task))*/
                        
                        
                     
                        }
                             
                }
                
                if(restrictedSpaceViewModel.allRestrictedSpaces.isEmpty)
                 {
                      RoundedRectangle(cornerRadius: 20).isHidden(true).frame(height:230)//Keeps safe space from the edge of screen 
                     Text("No Personal Activities Have Been Set :)...").fontWeight(.bold).font(.title)
                 }
                
                        
                        
                        /*Button(action: {
                                           
                                self.taskViewModel.retrieveAllTasks()
                                                    
                                                                     
                                    }) {
                                            Text("Retrieve")
                                        }*/
                
            }.onAppear{self.restrictedSpaceViewModel.getAllRestrictedSpace()
                //self.taskViewModel.getFirstTaskColor()  //also after clicking the delete button
            }.navigationBarTitle("Personal Activity", displayMode: .inline) .background(    Color(hex:"#fcfcfc")) //.padding(.top,5)
             
            
         
        
       
        
    }
}


/*struct RestrictedSpaceUI_Previews: PreviewProvider {
    
      @ObservedObject var taskViewModel = TaskViewModel()
    
    static var previews: some View {

        TaskList(taskViewModel:taskViewModel)
    }
}
*/
