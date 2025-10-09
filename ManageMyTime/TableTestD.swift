//
//  TableTestD.swift
//  ManageMyTime
//
//  Created by רן א on 30/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct MyPref: PreferenceKey {
    typealias Value = CGFloat

    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct SetWidthPreference: View {
    var body: some View {
        GeometryReader { proxy in
            Rectangle().fill(Color.clear).preference(key: MyPref.self, value: proxy.size.width)
        }
    }
}


struct TableTestD : View {
   var body: some View {

            GeometryReader { proxy in
                VStack{
                HStack(spacing: 0) {
                    VStack {
                        Text("Foo")
                        Text("Bar")
                    }.frame(width: proxy.size.width * 0.7, alignment: .leading).fixedSize().border(Color.red)
                    

                    VStack {
                        Text("W")
                        Text("Y")
                        Text("W")
                                           Text("Y")
                        Text("W")
                                           Text("Y")
                        Text("W")
                                           Text("Y")
                        Text("W")
                                           Text("Y")
                    }.frame(width: proxy.size.width * 0.15).fixedSize().border(Color.red)

                    VStack {
                        Text("X")
                        Text("Z")
                    }.frame(width: proxy.size.width * 0.15).fixedSize().border(Color.red)
                }
                HStack(spacing: 0) {
                             VStack {
                                 Text("Foo")
                                 Text("Bar")
                             }.frame(width: proxy.size.width * 0.7, alignment: .leading).fixedSize().border(Color.red)
                             

                             VStack {
                                 Text("W")
                                 Text("Y")
                             }.frame(width: proxy.size.width * 0.15).fixedSize().border(Color.red)

                             VStack {
                                 Text("X")
                                 Text("Z")
                             }.frame(width: proxy.size.width * 0.15).fixedSize().border(Color.red)
                         }
                }
            }.padding(20)
        }
    }

struct TableTestD_Previews: PreviewProvider {
    static var previews: some View {
        TableTestD()
    }
}
