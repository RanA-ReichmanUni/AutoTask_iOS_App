//
//  ScheduleViewRow.swift
//  ManageMyTime
//
//  Created by רן א on 01/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI



struct ScheduleViewRow: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.colorScheme) var colorScheme
    let helper = HelperFuncs()
    var timeChar = "25"

    @ObservedObject var taskViewModel: TaskViewModel
    var hoursRange = 6...24
    @State var show = false
    @State var key = false
    @Binding var rangeOfHours: [Int]

    // Column layout: 44pt time-label column + 7 equal flexible day columns.
    private var gridColumns: [GridItem] {
        [GridItem(.fixed(44), spacing: 0)] +
        Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // ── Title bar ─────────────────────────────────────────
                HStack {
                    Text("Weekly Schedule")
                        .font(Font.custom("MarkerFelt-Wide", size: 26))
                        .bold()
                    Spacer()
                    HStack {
                        Text(self.helper.dateToStringNormalizedExcludYear(date: Date().startOfWeek))
                            .font(Font.custom("MarkerFelt-Wide", size: 18))
                            .bold()
                            .foregroundColor(Color(.systemTeal))
                        Text(" - ")
                            .font(Font.custom("MarkerFelt-Wide", size: 18))
                            .bold()
                        Text(self.helper.dateToStringNormalizedExcludYear(date: Date().endOfWeek))
                            .font(Font.custom("MarkerFelt-Wide", size: 18))
                            .bold()
                            .foregroundColor(Color.blue)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(self.colorScheme == .dark
                                  ? Color.orange.opacity(0.3)
                                  : Color(hex: "#e6f2ff"))
                            .frame(width: 150, height: 40)
                    )
                }
                .padding(20)

                // ── Day-of-week header aligned to grid columns ────────
                WeeklyScheduleBar()

                // ── Schedule grid — LazyVGrid renders only visible rows
                ScrollView {
                    LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 0) {
                        ForEach(self.rangeOfHours, id: \.self) { hour in
                            // Column 0: time label
                            Text(hour > 9 ? "\(hour)" : "0\(hour)")
                                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                                .foregroundColor(self.colorScheme == .dark ? Color.orange : Color.gray)
                                .frame(width: 44, minHeight: geometry.size.height * 0.09, alignment: .center)
                                .background(self.colorScheme == .dark ? Color.black : Color(hex: "#efefef"))

                            // Columns 1–7: one task cell per day
                            ForEach(
                                self.taskViewModel.retrieveAllTasksByHourOrginal(hour: hour),
                                id: \.id
                            ) { daySlot in
                                WeeklyTasksRow(
                                    timeChar: String(hour),
                                    hourTasks: daySlot,
                                    taskViewModel: self.taskViewModel
                                )
                                .frame(minHeight: geometry.size.height * 0.09)
                                .border(
                                    self.colorScheme == .dark
                                        ? Color.orange.opacity(0.2)
                                        : Color.gray.opacity(0.1),
                                    width: 0.5
                                )
                            }
                        }
                    }
                }
            }
            .onAppear {
                // Populate all hours at once; LazyVGrid handles on-demand cell rendering.
                self.rangeOfHours = Array(6...24)
            }
            .onDisappear {
                self.rangeOfHours = []
                withAnimation(.ripple2()) {
                    self.taskViewModel.hoursRange = []
                }
                self.taskViewModel.retrieveAllTasks()
            }
            .background(
                self.colorScheme == .dark
                    ? Color.black
                    : Color(hex: "#f9f9f9").opacity(0.1)
            )
            .navigationBarTitle(Text("Weekly Schedule"))
        }
    }
}

/*struct ScheduleViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleViewRow()
    }
}
*/
