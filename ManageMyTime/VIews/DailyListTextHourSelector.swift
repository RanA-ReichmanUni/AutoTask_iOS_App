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
    
    func isIOS13VariationsChecker() -> Bool
    {
        if #available(iOS 14, *) {
            // use UICollectionViewCompositionalLayout
            return false
        } else {
            // show sad face emoji
            return true
        }
        
    }
    
    func isIOS13SpecificChecker() -> Bool
    {
        if #available(iOS 13.1, *) {
            // use UICollectionViewCompositionalLayout
            return false
        } else {
            // show sad face emoji
            return true
        }
        
    }
    var body: some View {
          HStack {
             if self.horizontalSizeClass == .compact {
                
                    Text(String(hour)).frame(width: geometryWidth/geometryWidthFactor, height:  geometryHeight/30)
                     
                                  Divider()
                
                                                
               } else if self.horizontalSizeClass == .regular{
                HStack{
                    
                    if(isIOS13VariationsChecker())
                    {
                        if(isIOS13SpecificChecker())
                        {
                            Text(String(hour)).frame(width: geometryWidth/15.3, height:  geometryHeight/30)
                                              
                            Divider()
                        }
                        else{
                            Text(String(hour)).frame(width: geometryWidth/15.3, height:  geometryHeight/30).padding(EdgeInsets(top: 0, leading: -90, bottom:0, trailing: 0))
                                              
                            Divider().padding(EdgeInsets(top: 0, leading: -40, bottom:0, trailing: 0))
                        }
                    }
                    else{
                        Text(String(hour)).frame(width: geometryWidth/8, height:  geometryHeight/30)
                                          
                        Divider()
                    }
                }
                       
               }
        }
    }
}
