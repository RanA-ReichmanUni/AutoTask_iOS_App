//
//  CardTaskRow.swift
//  ManageMyTime
//
//  Created by רן א on 10/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct CardTaskRow: View {
    
    var taskName1 : String
    var dueDate1 : String
    var importance1 : String
    var workTimeHour:Int
    var workTimeMinutes:Int
    var categories: [String]
    var color: Color
    
    var body: some View {
        
        ZStack(alignment: .leading) {
                    
                    Color.flatDarkCardBackground
                    Spacer()
                    HStack {
                         Spacer()
                       
                        
                        VStack(alignment: .leading) {
                            Text(taskName1)
                                .font(.headline)
                                .fontWeight(.bold)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                            
                            Text("Due:"+dueDate1)
                                .padding(.bottom, 5)
                            
                            HStack(alignment: .center) {
                                Image(systemName: "exclamationmark.circle")
                                Text(importance1)
                            }
                            .padding(.bottom, 5)
                            
                            HStack {
                                ForEach(categories, id: \.self) { category in
                                    CategoryPill(categoryName: category)
                                }
                            }
                            
                        }
                        .padding(.horizontal, 5)
                        Rectangle().fill(Color.white)
                        ZStack() {
                                                   Circle()
                                                       .fill(
                                                           LinearGradient(
                                                               gradient: Gradient(colors: [.white, color]),
                                                               startPoint: .topLeading,
                                                               endPoint: .bottomTrailing
                                                           )
                                                       )
                                                   
                                                   VStack {
                                                       Text("\(workTimeHour)"+":"+"\(workTimeMinutes)")
                                                           .font(.system(size: 20, weight: .bold))
                                                           .foregroundColor(.white)
                                                       
                                                       Text("h")
                                                           .font(.caption)
                                                           .foregroundColor(.white)
                                                   }
                                               }
                                               .frame(width: 70, height: 70, alignment: .center)
                          Spacer()
                    }
                    .padding(15)
        
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
        
    }
}

struct CardTaskRow_Previews: PreviewProvider {
    static var previews: some View {
        CardTaskRow(taskName1: "Check", dueDate1: "28/09/05", importance1: "High", workTimeHour: 6, workTimeMinutes: 30, categories: ["hi"], color: Color(.systemPink))
    }
}

extension UIColor {
    
    static let flatDarkBackground = UIColor(red: 36, green: 36, blue: 36)
    static let flatDarkCardBackground = UIColor(red: 46, green: 46, blue: 46)
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
}

extension Color {
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    public static var flatDarkBackground: Color {
        return Color(decimalRed: 36, green: 36, blue: 36)
    }
    
    public static var flatDarkCardBackground: Color {
        return Color(decimalRed: 255, green: 255, blue: 255)
    }
}

struct CategoryPill: View {
    
    var categoryName: String
    var fontSize: CGFloat = 12.0
    
    var body: some View {
        ZStack {
            Text(categoryName)
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(2)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.green)
                .cornerRadius(5)
        }
    }
}
