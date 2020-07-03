//
//  WeeklyScheduleBar.swift
//  ManageMyTime
//
//  Created by רן א on 03/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct WeeklyScheduleBar: View {
    var body: some View {
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
    }
}

struct WeeklyScheduleBar_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyScheduleBar()
    }
}
