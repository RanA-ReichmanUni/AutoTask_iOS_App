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
        HStack(spacing: 0) {
            // Placeholder matching the 44pt fixed time-label column in the LazyVGrid
            Color.clear
                .frame(width: 44, height: 30)

            // Seven flexible day headers — one per grid day column
            ForEach(
                [("Sun", Color.blue),
                 ("Mon", Color(.systemTeal)),
                 ("Tue", Color.blue),
                 ("Wed", Color(.systemTeal)),
                 ("Thu", Color.blue),
                 ("Fri", Color(.systemTeal)),
                 ("Sat", Color.blue)],
                id: \.0
            ) { day, color in
                Text(day)
                    .font(Font.custom("MarkerFelt-Wide", size: 13))
                    .foregroundColor(color)
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
            }
        }
        .frame(height: 30)
        .background(self.colorScheme == .dark ? Color.black : Color(hex: "#e6f2ff"))
    }
}

struct WeeklyScheduleBar_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyScheduleBar()
    }
}
