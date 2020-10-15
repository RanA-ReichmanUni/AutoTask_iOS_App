//
//  WeeklyScheduleBar.swift
//  ManageMyTime
//
//  Created by רן א on 03/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct WeeklyScheduleBar: View {
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
         HStack(alignment: .top){
                                  Image(systemName: "clock").padding(EdgeInsets(top: 9, leading: 5, bottom: 0, trailing: -6)).foregroundColor(Color(.systemTeal))
                                  GeometryReader{geometry in
                                      Text("Sun").font(Font.custom("MarkerFelt-Wide", size: 18)).foregroundColor(Color.blue).frame(width: geometry.size.width/5, height:  geometry.size.height)
                                      Text("Mon").font(Font.custom("MarkerFelt-Wide", size: 18)).foregroundColor(Color(.systemTeal)).frame(width: geometry.size.width/2.04, height:  geometry.size.height)
                                      Text("Tue").font(Font.custom("MarkerFelt-Wide", size: 18)).foregroundColor(Color.blue).frame(width: geometry.size.width/1.319, height:  geometry.size.height)
                                      Text("Wen").font(Font.custom("MarkerFelt-Wide", size: 18)).foregroundColor(Color(.systemTeal)).frame(width: geometry.size.width/0.95, height:  geometry.size.height)
                                      Text("Thu").font(Font.custom("MarkerFelt-Wide", size: 18)).foregroundColor(Color.blue).frame(width: geometry.size.width/0.74, height:  geometry.size.height)
                                    Text("Fri").font(Font.custom("MarkerFelt-Wide", size: 18)).foregroundColor(Color(.systemTeal)).frame(width: geometry.size.width/0.61, height:  geometry.size.height)
                                      Text("Sat").font(Font.custom("MarkerFelt-Wide", size: 18)).foregroundColor(Color.blue).frame(width: geometry.size.width/0.52, height:  geometry.size.height)
                                  }
         }.frame(height: 30).padding().background(self.colorScheme == .dark ? Color.black : Color(hex:"#e6f2ff"))//was 30 in height
    }
}

struct WeeklyScheduleBar_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyScheduleBar()
    }
}
