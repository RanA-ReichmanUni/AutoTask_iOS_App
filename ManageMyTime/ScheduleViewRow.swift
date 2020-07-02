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
            
        
        HStack{
         
            Text(self.timeChar).padding().position(x: 25, y: 20)
            
       
               HStack{
                   
                Text(self.columns[0]).position(x: -140, y: 20).lineSpacing(2).lineLimit(3).font(.system(size: 16))
                Text(self.columns[1]).position(x: -112, y: 20).font(.system(size: 10))
                Text(self.columns[2]).position(x: -92, y: 20).lineSpacing(2).lineLimit(3)
                Text(self.columns[3]).position(x: -72, y: 20).lineSpacing(2).lineLimit(3)
                Text(self.columns[4]).position(x: -45, y: 20).lineSpacing(2).lineLimit(3)
                Text(self.columns[5]).position(x: -20, y: 20).lineSpacing(2).lineLimit(3)
                Text(self.columns[6]).position(x: 0, y: 20).lineSpacing(2).lineLimit(3)
                    
               
            }
            }
        }
    }
}

struct ScheduleViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleViewRow(timeChar:"8",columns: ["hello","what's up","infi b","algebra b","bla bla bla","sadfafas","fdsgfdsg"])
    }
}

