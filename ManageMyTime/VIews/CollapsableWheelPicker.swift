//
//  CollapsableWheelPicker.swift
//  ManageMyTime
//
//  Created by רן א on 04/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct CollapsableWheelPicker<Label, Item, Content>: View
where Content: View, Item: Hashable, Label: View
{
    @Binding var showsPicker: Bool
    @Binding var hidePicker:Bool
    var picker: Picker<Label, Item, Content>
    init<S: StringProtocol>(_ title: S,
                            showsPicker: Binding<Bool>,
                            hidePicker: Binding<Bool>,
                            selection: Binding<Item>,
                            @ViewBuilder content: ()->Content)
    where Label == Text
    {
        self._showsPicker = showsPicker
        self._hidePicker = hidePicker
        self.picker = Picker(title, selection: selection, content: content)
    }
    var body: some View {
        
        Group {
            if showsPicker {
                VStack {
                  /*  HStack {
                        Spacer()
                        Button("Close") {
                            self.hidePicker=true
                              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.showsPicker = false}
                            
                        }
                    }*/
                    HStack{
                        Spacer()
                        picker.frame(width:60).clipped().isHidden(self.hidePicker)
                        Spacer()
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
        }
    }
}
