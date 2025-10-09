//
//  SepratedTaskList.swift
//  ManageMyTime
//
//  Created by רן א on 29/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

/*
struct SeparatedTaskList: View {
    
    //var taskData : Task
   // var taskViewModel = TaskViewModel()
    
    
    @ObservedObject var taskViewModel=TaskViewModel()//previously it was @EnvironmentObject
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var offset: CGFloat = 0
     @State private var padding: CGFloat = 0
    var separatedTasks:[TasksAndDates]
    var helper = HelperFuncs()

    var body: some View {

  
            ScrollView{
                VStack{
                Text("Weekly Tasks").font(Font.custom("Chalkduster", size: 30)).fontWeight(.bold).font(.title).padding(EdgeInsets(top: 50, leading: 0, bottom: -70, trailing: 0))
                 Divider().padding(EdgeInsets(top: 60, leading: 0, bottom: -70, trailing: 0))
                }
                ForEach(self.separatedTasks) { tasksAndDate in
                    VStack(spacing:0){
             

                        
                        DayTaskList(allTasks: tasksAndDate.tasks,dayOfTheWeek:tasksAndDate.date.dayOfWeek())
                        

                 
                    }

                
            }
                
                if(self.separatedTasks.isEmpty)
                 {
                     Spacer()
                     Text("No Tasks Have Been Scheduled :)...").fontWeight(.bold).font(.title)
                 }
        }
      
        
       
        
    }
}


/*struct SeparatedTaskList_Previews: PreviewProvider {
    
      @ObservedObject var taskViewModel = TaskViewModel()
    
    static var previews: some View {

        TaskList(taskViewModel:taskViewModel)
    }
}
*/
*/
