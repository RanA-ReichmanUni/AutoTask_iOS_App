//
//  BigChar.swift
//  ManageMyTime
//
//  Created by רן א on 04/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct BigCharIOS13: View {
    var hour:String
    var body: some View {
        GeometryReader{ geometry in
            HStack {
                if(Int(self.hour)==Date().hour)
                {
                    
                    DailyListTextHourSelector(hour: self.hour, geometryWidth: geometry.size.width+50, geometryHeight: geometry.size.height)
                    /*Text(hour).background(RoundedRectangle(cornerRadius: 6).fill(Color.red)).foregroundColor(.white)
                    
                     
                     Divider().padding(EdgeInsets(top: 5, leading: 1, bottom:0, trailing: 5))*/
                }
                else{
                             DailyListTextHourSelector(hour: self.hour, geometryWidth: geometry.size.width+50, geometryHeight: geometry.size.height)
                   /* Text(hour)
                                   
                                    
                    Divider().padding(EdgeInsets(top: 5, leading: 1, bottom:0, trailing: 5))*/
                }
                  }
        }
    }
}
