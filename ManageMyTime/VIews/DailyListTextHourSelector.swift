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
    @State var geometryWidthFactor:CGFloat=8
    
    func geometryReaderVersionCorrector()
    {
        
        if #available(iOS 14, *) {
            // use UICollectionViewCompositionalLayout
        } else {
            // show sad face emoji
            self.geometryWidthFactor=18
            
        }
        
        
    }
    var body: some View {
          HStack {
             if self.horizontalSizeClass == .compact {
                
                    Text(String(hour)).frame(width: geometryWidth/geometryWidthFactor, height:  geometryHeight/30)
                     
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
