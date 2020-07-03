//
//  ScheduleViewRow.swift
//  ManageMyTime
//
//  Created by רן א on 01/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct ScheduleViewRow: View {
    
    
    var timeChar : String
    var columns : [String]
        
    var body: some View {
        
        GeometryReader { geometry in
            
        
       VStack{
        HStack{
                           Image(systemName: "clock").padding(EdgeInsets(top: 5, leading: 0, bottom: 1, trailing: 0)).foregroundColor(.orange)
                           GeometryReader{geometry in
                               Text("S").foregroundColor(Color.blue).frame(width: geometry.size.width/5.5, height:  geometry.size.height)
                                    
                               Text("M").foregroundColor(Color.red).frame(width: geometry.size.width/2.2, height:  geometry.size.height)
                               Text("T").foregroundColor(Color.blue).frame(width: geometry.size.width/1.34, height:  geometry.size.height)
                               Text("W").foregroundColor(Color.red).frame(width: geometry.size.width/0.97, height:  geometry.size.height)
                               Text("T").foregroundColor(Color.blue).frame(width: geometry.size.width/0.76, height:  geometry.size.height)
                               Text("F").foregroundColor(Color.red).frame(width: geometry.size.width/0.627, height:  geometry.size.height)
                               Text("S").foregroundColor(Color.blue).frame(width: geometry.size.width/0.53, height:  geometry.size.height)
                           }
            }.frame(height: 30).padding()
        List{
                
                            
            
       
                   HStack
                    {
                        WeeklyTasksRow(timeChar: "23", hourTasks: ["Algebra excersize 1","Algebra excersize 1","Algebra excersize 1","Algebra excersize 1","Algebra excersize 1","Algebra excersize 1","Algebra excersize 1"], heightFactor: CGFloat(1.5))
                        
                        /*Text(self.timeChar).padding(EdgeInsets(top: 5, leading: 0, bottom:0, trailing: 10))
                        
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-5, trailing: 0))
                        
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))*/
                    }
                HStack{
                     Text(self.timeChar).padding(EdgeInsets(top: 5, leading: 0, bottom:0, trailing: 10))
                
                    TestTaskRow(heightFactor: CGFloat(0.7)).padding(EdgeInsets(top:-8, leading: 0, bottom:0, trailing: 0))
                    
                    TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                }
            }.padding(EdgeInsets(top:-0, leading: 0, bottom:0, trailing: 0))
               
            
            }
        }
    }
}

struct ScheduleViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleViewRow(timeChar:"23",columns: ["hello","what's up","infi b","algebra b","bla bla bla","sadfafas","fdsgfdsg"])/*.previewLayout(.fixed(width: 600, height: 300 ))*/
    }
}

