//
//  FirstRowGen.swift
//  ManageMyTime
//
//  Created by רן א on 22/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct FirstRowGen: View {
    var hour:String
    var geometryWidth:CGFloat
    var geometryHeight:CGFloat
    var initialVlaue:Int
    var currentValue:Int
    var body: some View {
        
        HStack{
            if(initialVlaue==currentValue)
            {
                
                
                 Image(systemName: "clock").frame(width: geometryWidth/18, height:  geometryHeight/30).foregroundColor(.red)
                
            }
            else{
                
                    ListTextHourSelector(hour: "0"+String(hour), geometryWidth: geometryWidth, geometryHeight: geometryHeight)
            }
        }
    }
}

/*struct FirstRowGen_Previews: PreviewProvider {
    static var previews: some View {
        FirstRowGen()
    }
}
*/


