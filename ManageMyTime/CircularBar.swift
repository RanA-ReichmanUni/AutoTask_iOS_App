//
//  CircularBar.swift
//  ManageMyTime
//
//  Created by רן א on 02/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct CircularBar: View {
    
    @State var progress: CGFloat = 0
    var percentage:CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.5)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 12.0, dash: [8]))
                    .frame(width: 200, height: 200)
                    .rotationEffect(Angle(degrees: -180))
                Circle()
                    .trim(from: 0.0, to: progress/2)
                    .stroke(Color.blue, lineWidth: 12.0)
                    .frame(width: 200, height: 200)
                    .rotationEffect(Angle(degrees: -180))
                Text("\(Int(self.progress*100))%")
                    .font(.custom("HelveticaNeue", size: 20.0))
            }
        }.onAppear { self.startLoading() }
    }
    
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            withAnimation() {
                self.progress += 0.01
                if self.progress >= self.percentage {
                    timer.invalidate()
                }
            }
        }
    }
}

struct CircularBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularBar(percentage:CGFloat(0.4))
    }
}
