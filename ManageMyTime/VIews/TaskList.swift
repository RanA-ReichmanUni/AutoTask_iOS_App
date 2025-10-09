//
//  TaskList.swift
//  ManageMyTime
//
//  Created by רן א on 29/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI


struct TaskList: View {
    
    //var taskData : Task
   // var taskViewModel = TaskViewModel()
    
    
    @ObservedObject var taskViewModel=TaskViewModel()//previously it was @EnvironmentObject
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var offset: CGFloat = 0
     @State private var padding: CGFloat = 0
    var helper = HelperFuncs()
    var dayNames = [" Active Tasks "," Sunday "," Monday "," Tuesday "," Wednesday "," Thursday "," Friday "," Saturday "]
    @State var show:Bool=false
    @State var dayIndexSelector:Int
    var geometry:GeometryProxy
    @Binding var addTaskFlag:Bool
    @Binding var listFlag:Bool
    @State var showAdd=false
    @State var type=1
    @State var animationType:String=animationStyle.smooth.rawValue
    
    private func GetTasksByChoise() {
            
        taskViewModel.GetDayTasksByIndex(index: dayIndexSelector)
           
          }
    
    var body: some View {

       GeometryReader{geometry in
        ZStack{
            ScrollView{
                
               
              
                     ZStack{
                              
                              HStack{
                               
                                    Spacer()
                                        
                                Picker(selection: self.$dayIndexSelector.onUpdate(self.GetTasksByChoise), label:Text("")) {
                                                  ForEach(self.dayNames ,id:\.self) { day in
                                                    
                                                    Text(day).strikethrough(self.dayNames.firstIndex(of: day) == 0 ? false : ((self.taskViewModel.DayStringToNumConverter(dayOfTheWeek: Date().dayOfWeek()!) < self.dayNames.firstIndex(of: day) ?? 6) ? false : true), color: Color.black
                                                    ).font(Font.custom("ChalkboardSE-Regular", size: 25)).tag(Int(self.dayNames.firstIndex(of: day)!)).background(RoundedRectangle(cornerRadius: 20).fill(Color.blue).opacity(self.dayIndexSelector==Int(self.dayNames.firstIndex(of: day)!) ? 1 : 0)).foregroundColor(
                                                        self.colorScheme == .dark ? self.dayIndexSelector==Int(self.dayNames.firstIndex(of: day)!) ? Color.white : Color.orange :
                                                        self.dayIndexSelector==Int(self.dayNames.firstIndex(of: day)!) ? Color.white : Color.black)
                                                  }
                                                                               .labelsHidden()
                                                                     
                                    }.frame(width:geometry.size.width/2.3).pickerStyle(WheelPickerStyle()).clipped().padding(EdgeInsets(top: -200, leading: 0, bottom: 0, trailing: 0))

                                        
                                //  Text("All Tasks").font(Font.custom("Chalkduster", size: 30)).fontWeight(.bold).font(.title).padding(EdgeInsets(top: -100, leading: 5, bottom: 0, trailing: 0))
                                
                                //  Divider().foregroundColor(taskViewModel.getTaskColor(task: allTasks[0])).frame(height:10).background(taskViewModel.getTaskColor(task: allTasks[0]))
                                Spacer()
                                                              }
                              
                              RoundedRectangle(cornerRadius: 20).isHidden(true).frame(height:350).onAppear{self.dayIndexSelector=self.taskViewModel.latestDayChoiseIndex
                        }
                              //Keeps safe space from the edge of screen so the first card can pull up to a safe area
                          }
                
                 
                    
                    ForEach(self.taskViewModel.allTasks, id: \.id) { task in
                        
                        VStack{
                            if(self.colorScheme != .dark)
                            {
                                VStack{
                                   /* NavigationLink(destination: DetailedTaskUI( taskViewModel:self.taskViewModel,taskName: task.taskName,importance: task.importance!,dueDate: task.dueDate,notes: task.notes!, asstimatedWorkTimeHour: task.asstimatedWorkTime.hour,asstimatedWorkTimeMinutes:task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes,day:task.date.day,month:task.date.month,year:task.date.year,taskId:task.id,color:self.taskViewModel.getTaskColor(task:task))){*/
                                    if(self.taskViewModel.allTasks.firstIndex(of: task) != self.taskViewModel.allTasks.count-1)
                                    {
                                        if(self.show)//Implemented lazyLoading of list cards,tremendous performance upgrade
                                          {
                                            CardTaskRow( taskViewModel:self.taskViewModel,taskId:task.id,taskName1: task.taskName, dueDate1: self.helper.dateToStringNormalized(date: task.dueDate), importance1: task.importance!, workTimeHour: task.asstimatedWorkTime.hour, workTimeMinutes: task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes, scheduledDate: self.helper.dateToString(date: task.date), color: self.taskViewModel.getTaskColor(task:task),offset:self.$offset,date:task.date,notes:task.notes!,id:task.id,dueDate:task.dueDate,completed:task.completed,internalId:task.internalId!,isClickable:true,geometry:geometry).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}.animation(taskViewModel.GetAnimationStyleSettings()==animationStyle.smooth.rawValue ? .easeInOut(duration:0.6) : (self.animationType==animationStyle.fast.rawValue ? .ripple() : .ripple2()))//.onDisappear{self.show=false}
                                        }
                                          else{
                                            RoundedRectangle(cornerRadius: 20).isHidden(true).frame(height:350).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.show=true}.animation(.ripple())//When reaching exchange the placeholder with real card
                                            
                                        }
                                        
                                        
                                    }
                                    else{
                                           
                                             CardTaskRow( taskViewModel:self.taskViewModel,taskId:task.id,taskName1: task.taskName, dueDate1: self.helper.dateToStringNormalized(date: task.dueDate), importance1: task.importance!, workTimeHour: task.asstimatedWorkTime.hour, workTimeMinutes: task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes, scheduledDate: self.helper.dateToString(date: task.date), color: self.taskViewModel.getTaskColor(task:task),offset:self.$offset,date:task.date,notes:task.notes!,id:task.id,dueDate:task.dueDate,completed:task.completed,internalId:task.internalId!,isClickable:false,geometry:geometry).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}.onAppear{
                                                    self.dayIndexSelector=self.taskViewModel.latestDayChoiseIndex
                                             }.animation(self.animationType==animationStyle.smooth.rawValue ? .easeInOut(duration:0.6) : (taskViewModel.GetAnimationStyleSettings()==animationStyle.fast.rawValue ? .ripple() : .ripple2()))
                                        
                                            
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
                                    
                                 
                                }
                        }
                        else{
                                
                                VStack{
                                        /* NavigationLink(destination: DetailedTaskUI( taskViewModel:self.taskViewModel,taskName: task.taskName,importance: task.importance!,dueDate: task.dueDate,notes: task.notes!, asstimatedWorkTimeHour: task.asstimatedWorkTime.hour,asstimatedWorkTimeMinutes:task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes,day:task.date.day,month:task.date.month,year:task.date.year,taskId:task.id,color:self.taskViewModel.getTaskColor(task:task))){*/
                                         if(self.taskViewModel.allTasks.firstIndex(of: task) != self.taskViewModel.allTasks.count-1)
                                         {
                                             if(self.show)//Implemented lazyLoading of list cards,tremendous performance upgrade
                                               {
                                                 CardTaskRow( taskViewModel:self.taskViewModel,taskId:task.id,taskName1: task.taskName, dueDate1: self.helper.dateToStringNormalized(date: task.dueDate), importance1: task.importance!, workTimeHour: task.asstimatedWorkTime.hour, workTimeMinutes: task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes, scheduledDate: self.helper.dateToString(date: task.date), color: self.taskViewModel.getTaskColor(task:task),offset:self.$offset,date:task.date,notes:task.notes!,id:task.id,dueDate:task.dueDate,completed:task.completed,internalId:task.internalId!,isClickable:true,geometry:geometry).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}//.onDisappear{self.show=false}
                                             }
                                               else{
                                                  RoundedRectangle(cornerRadius: 20).isHidden(true).frame(height:350).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.show=true}//When reaching exchange the placeholder with real card
                                                 
                                             }
                                             
                                             
                                         }
                                         else{
                                                
                                                  CardTaskRow( taskViewModel:self.taskViewModel,taskId:task.id,taskName1: task.taskName, dueDate1: self.helper.dateToStringNormalized(date: task.dueDate), importance1: task.importance!, workTimeHour: task.asstimatedWorkTime.hour, workTimeMinutes: task.asstimatedWorkTime.minutes,startTimeHour:task.startTime!.hour,startTimeMinutes:task.startTime!.minutes,endTimeHour:task.endTime!.hour,endTimeMinutes:task.endTime!.minutes, scheduledDate: self.helper.dateToString(date: task.date), color: self.taskViewModel.getTaskColor(task:task),offset:self.$offset,date:task.date,notes:task.notes!,id:task.id,dueDate:task.dueDate,completed:task.completed,internalId:task.internalId!,isClickable:false,geometry:geometry).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: -160, leading: 0, bottom: self.padding, trailing: 0)).offset(y:self.offset).onAppear{self.offset=18}.onAppear{
                                                          self.dayIndexSelector=self.taskViewModel.latestDayChoiseIndex
                                                  }
                                             
                                                 
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
                
               
                      
                     
                    if(self.taskViewModel.allTasks.isEmpty && self.dayIndexSelector == 0)
                {
                    
                    Text("There Are No Scheduled Tasks...").font(Font.custom("Chalkduster", size: 30))//.background(RoundedRectangle(cornerRadius: 20).fill(Color(hex:"#f7f5f5")).frame(width:geometry.size.width/1.08,height:geometry.size.height/5.7)).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black).frame(width:geometry.size.width/1.08,height:geometry.size.height/5.7)).padding()
                }
                else if(self.taskViewModel.allTasks.isEmpty){
                    
                        Text("There Are No Scheduled Tasks For This Day...").font(Font.custom("Chalkduster", size: 30))//.background(RoundedRectangle(cornerRadius: 20).fill(Color(hex:"#f7f5f5")).frame(width:geometry.size.width/1.08,height:geometry.size.height/5.7)).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black).frame(width:geometry.size.width/1.08,height:geometry.size.height/5.7)).padding()
                }
                      
                //.navigationBarTitle(Text("Active Tasks").foregroundColor(.green))
                        
                        
                        /*Button(action: {
                                           
                                self.taskViewModel.retrieveAllTasks()
                                                    
                                                                     
                                    }) {
                                            Text("Retrieve")
                                        }*/
               
                
            }.background(self.colorScheme == .dark ? Color.black : Color.white)
            
            
            ZStack(alignment: .bottomTrailing) {
                          Rectangle()
                              .foregroundColor(.clear)
                              .frame(maxWidth: .infinity, maxHeight: .infinity)
                ExpandingMenu(addTaskFlag:self.$addTaskFlag,listFlag:self.$listFlag,showAddTask:self.$showAdd,type:self.$type)
                              .padding()
                      }
        }
       }.sheet(isPresented: self.$showAdd) {
        if(self.type==1)
        {
            if(self.colorScheme == .dark)
            {
                AddTask(taskViewModel: self.taskViewModel, listFlag: self.$listFlag, addTaskFlag: self.$addTaskFlag,notificationValues:self.taskViewModel.StringRangeCreator(start:0,end:60)).onAppear {
                   UITableView.appearance().backgroundColor = .black
                }
            }
            else{
              AddTask(taskViewModel: self.taskViewModel, listFlag: self.$listFlag, addTaskFlag: self.$addTaskFlag,notificationValues:self.taskViewModel.StringRangeCreator(start:0,end:60))
            }
        }
        else{
            if(self.colorScheme == .dark)
                     {
                         AddRestrictedSpaceUI(taskViewModel: self.taskViewModel, listFlag: self.$listFlag, addTaskFlag: self.$addTaskFlag,notificationValues:self.taskViewModel.StringRangeCreator(start:0,end:60)).onAppear {
                            UITableView.appearance().backgroundColor = .black
                         }
                     }
                     else{
                       AddRestrictedSpaceUI(taskViewModel: self.taskViewModel, listFlag: self.$listFlag, addTaskFlag: self.$addTaskFlag,notificationValues:self.taskViewModel.StringRangeCreator(start:0,end:60))
                     }
            
        }
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
