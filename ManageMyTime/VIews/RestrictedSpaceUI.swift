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
    @ObservedObject var taskViewModel=TaskViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var offset: CGFloat = 0
     @State private var padding: CGFloat = 0
    @State var show=false
    var helper = HelperFuncs()
  
    var body: some View {

  
            ScrollView{
                
                RoundedRectangle(cornerRadius: 20).isHidden(true).frame(height:250)
                                             //Keeps safe space from the edge of screen so the first card can pull up to a safe area
              
                ForEach(restrictedSpaceViewModel.allRestrictedSpaces, id: \.self) { restrictedSpace in
                     VStack{
                           if(self.colorScheme != .dark)
                           {
                               VStack{
                                  /* NavigationLink(destination: DetailedTaskUI( taskViewModel:self.taskViewModel,taskName: task.taskName,importance: task.importance!,dueDate: task.dueDate,notes: task.notes!, asstimatedWorkTimeHour: task.asstimatedWorkTime.hour,asstimatedWorkTimeMinutes:task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes,day:task.date.day,month:task.date.month,year:task.date.year,taskId:task.id,color:self.taskViewModel.getTaskColor(task:task))){*/
                                if(self.restrictedSpaceViewModel.allRestrictedSpaces.firstIndex(of: restrictedSpace) != self.restrictedSpaceViewModel.allRestrictedSpaces.count-1)
                                   {
                                       if(self.show)//Implemented lazyLoading of list cards,tremendous performance upgrade
                                         {
                                            RestrictedSpaceVerticalCard(restrictedSpaceViewModel:self.restrictedSpaceViewModel, taskViewModel:self.taskViewModel,restrictedSpaceId:restrictedSpace.id,taskName1: restrictedSpace.name, difficulty:restrictedSpace.difficulty, startTimeHour:restrictedSpace.startTime.hour,startTimeMinutes:restrictedSpace.startTime.minutes,endTimeHour:restrictedSpace.endTime.hour,endTimeMinutes:restrictedSpace.endTime.minutes, dayOfTheWeek: restrictedSpace.dayOfTheWeek, color: self.restrictedSpaceViewModel.getRestrictedSpaceColor(restrictedSpace: restrictedSpace),offset:self.$offset,id:restrictedSpace.id,isClickable:true).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}//.onDisappear{self.show=false}
                                       }
                                         else{
                                            RoundedRectangle(cornerRadius: 20).isHidden(true).frame(height:350).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.show=true}//When reaching exchange the placeholder with real card
                                           
                                       }
                                       
                                       
                                   }
                                   else{
                                          
                                    RestrictedSpaceVerticalCard(restrictedSpaceViewModel:self.restrictedSpaceViewModel, taskViewModel:self.taskViewModel,restrictedSpaceId:restrictedSpace.id,taskName1: restrictedSpace.name, difficulty:restrictedSpace.difficulty, startTimeHour:restrictedSpace.startTime.hour,startTimeMinutes:restrictedSpace.startTime.minutes,endTimeHour:restrictedSpace.endTime.hour,endTimeMinutes:restrictedSpace.endTime.minutes, dayOfTheWeek: restrictedSpace.dayOfTheWeek, color: self.restrictedSpaceViewModel.getRestrictedSpaceColor(restrictedSpace: restrictedSpace),offset:self.$offset,id:restrictedSpace.id,isClickable:false).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}
                                       
                                           
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
                                   
                                
                               }.animation(.easeInOut(duration:0.6))
                       }
                       else{
                               
                          VStack{
                                  
                                if(self.restrictedSpaceViewModel.allRestrictedSpaces.firstIndex(of: restrictedSpace) != self.restrictedSpaceViewModel.allRestrictedSpaces.count-1)
                                   {
                                       if(self.show)//Implemented lazyLoading of list cards,tremendous performance upgrade
                                         {
                                            RestrictedSpaceVerticalCard(restrictedSpaceViewModel:self.restrictedSpaceViewModel, taskViewModel:self.taskViewModel,restrictedSpaceId:restrictedSpace.id,taskName1: restrictedSpace.name, difficulty:restrictedSpace.difficulty, startTimeHour:restrictedSpace.startTime.hour,startTimeMinutes:restrictedSpace.startTime.minutes,endTimeHour:restrictedSpace.endTime.hour,endTimeMinutes:restrictedSpace.endTime.minutes, dayOfTheWeek: restrictedSpace.dayOfTheWeek, color: self.restrictedSpaceViewModel.getRestrictedSpaceColor(restrictedSpace: restrictedSpace),offset:self.$offset,id:restrictedSpace.id,isClickable:true).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}//.onDisappear{self.show=false}
                                       }
                                         else{
                                            RoundedRectangle(cornerRadius: 20).isHidden(true).frame(height:350).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.show=true}//When reaching exchange the placeholder with real card
                                           
                                       }
                                       
                                       
                                   }
                                   else{
                                          
                                    RestrictedSpaceVerticalCard(restrictedSpaceViewModel:self.restrictedSpaceViewModel, taskViewModel:self.taskViewModel,restrictedSpaceId:restrictedSpace.id,taskName1: restrictedSpace.name, difficulty:restrictedSpace.difficulty, startTimeHour:restrictedSpace.startTime.hour,startTimeMinutes:restrictedSpace.startTime.minutes,endTimeHour:restrictedSpace.endTime.hour,endTimeMinutes:restrictedSpace.endTime.minutes, dayOfTheWeek: restrictedSpace.dayOfTheWeek, color: self.restrictedSpaceViewModel.getRestrictedSpaceColor(restrictedSpace: restrictedSpace),offset:self.$offset,id:restrictedSpace.id,isClickable:false).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}
                                       
                                           
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
                                   
                                
                               }//.animation(.easeInOut(duration:0.6))
                           }
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
            }.background(self.colorScheme == .dark ? Color.black : Color(hex:"#fcfcfc")).navigationBarTitle("Personal Activity", displayMode: .inline) //.padding(.top,5)
             
            
         
        
       
        
    }
}


/*struct RestrictedSpaceUI_Previews: PreviewProvider {
    
      @ObservedObject var taskViewModel = TaskViewModel()
    
    static var previews: some View {

        TaskList(taskViewModel:taskViewModel)
    }
}
*/
