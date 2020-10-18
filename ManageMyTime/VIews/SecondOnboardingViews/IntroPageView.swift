//
//  IntroPageView.swift
//  ManageMyTime
//
//  Created by רן א on 18/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct IntroPage {
    let imageName: String
    let title: String
    let description: String
}

struct IntroPageView: View {
    let page: IntroPage
    var body: some View {
        VStack {
            Spacer()
            Image(self.page.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Group {
                HStack {
                    Text(self.page.title)
                        .font(.title)
                        .foregroundColor(.blue)
                    Spacer()
                }
                HStack {
                    Text(self.page.description)
                    Spacer()
                }
            }
            .padding()
        }
    }
}
