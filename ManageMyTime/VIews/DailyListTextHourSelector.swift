//
//  DailyListTextHourSelector.swift
//  ManageMyTime
//
//  Created by רן א on 19/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct DailyListTextHourSelector: View {
    
     @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var hour:String
    var geometryWidth:CGFloat
    var geometryHeight:CGFloat
    
    var body: some View {
          HStack {
             if self.horizontalSizeClass == .compact {
                
                    Text(String(hour)).frame(width: geometryWidth/18, height:  geometryHeight/30)
                     
                                  Divider()
                
                                                
               } else if self.horizontalSizeClass == .regular{
                HStack{
                    
                
                Text(String(hour)).frame(width: geometryWidth/15.3, height:  geometryHeight/30).padding(EdgeInsets(top: 0, leading: -90, bottom:0, trailing: 0))
                                  
                Divider().padding(EdgeInsets(top: 0, leading: -40, bottom:0, trailing: 0))
                }
                       
               }
        }
    }
}
