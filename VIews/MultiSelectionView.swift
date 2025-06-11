//
//  MultiSelectionView.swift
//  ManageMyTime
//
//  Created by רן א on 11/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct MultiSelectionView<Selectable: Identifiable & Hashable>: View {
    let options: [Selectable]
    let optionToString: (Selectable) -> String

    @Binding var selected: Set<Selectable>

    var body: some View {
        List {
            ForEach(options) { selectable in
                Button(action: { self.toggleSelection(selectable: selectable) }) {
                    HStack {
                        Text(self.optionToString(selectable)).foregroundColor(.black)
                        Spacer()
                        if self.selected.contains { $0.id == selectable.id } {
                            Image(systemName: "checkmark").foregroundColor(.accentColor)
                        }
                    }
                }.tag(selectable.id)
            }
        }.listStyle(GroupedListStyle())
    }

    private func toggleSelection(selectable: Selectable) {
        if let existingIndex = selected.firstIndex(where: { $0.id == selectable.id }) {
            selected.remove(at: existingIndex)
        } else {
            selected.insert(selectable)
        }
    }
}

struct IdentifiableString: Identifiable, Hashable {
    let string: String
    var id: String { string }
}
