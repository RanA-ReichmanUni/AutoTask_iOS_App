//
//  ListTextHourSelector.swift
//  ManageMyTime
//
//  Created by רן א on 28/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct ListTextHourSelector: View {
    
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
                    
                
                Text(String(hour)).frame(width: geometryWidth/15.3, height:  geometryHeight/30).padding(EdgeInsets(top: 0, leading: 0.1, bottom:0, trailing: 0))
                                  
                Divider().padding(EdgeInsets(top: 0, leading: -14, bottom:0, trailing: 0))
                }
                       
               }
        }
    }
}
/*
struct ListTextHourSelector_Previews: PreviewProvider {
    static var previews: some View {
        ListTextHourSelector()
    }
}
*/
