//
//  ScheduleView.swift
//  ManageMyTime
//
//  Created by רן א on 01/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        Group{
        ScrollView {
            Group{
            VStack{
                Group{
                HStack{
                     Image(systemName: "clock")
                        .padding()
                    Text("S").foregroundColor(Color.red).lineLimit(2).padding()
                    
                     Text("M").foregroundColor(Color.red).padding()
                     Text("T").foregroundColor(Color.red).padding()
                     Text("W").foregroundColor(Color.red).padding()
                     Text("T").foregroundColor(Color.red).padding()
                     Text("F").foregroundColor(Color.red).padding()
                     Text("S").foregroundColor(Color.red).padding()
                }
                    
                    ScheduleViewRow(timeChar:"8",columns: ["hello","what's up","infi b","algebra b","bla bla bla","sadfafas","fdsgfdsg"])
                
                
               
                }
            }
            }
        }
    }
}
}
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView().previewLayout(.fixed(width: 600, height: 300 ))
    }
}
