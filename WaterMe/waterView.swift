//
//  waterView.swift
//  WaterMe
//
//  Created by Маркі on 10.12.2020.
//

import Foundation
import SwiftUI



struct WaterPercentView: View {
    var percent: Int
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        GeometryReader { geometry in
            GeometryReader { geo in
                ZStack {
                    Text("\(Int(self.percent))%")
                        .foregroundColor(.white)
                        .font(Font.system(size: 0.25 * min(geo.size.width, geo.size.height) )).offset(y: 100)
                    WaterWaves(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                        .fill(percent < 100 ? Color(red: 0.58, green: 0.67, blue: 0.83, opacity: 0.3) : Color(red: 0.38, green: 0.69, blue: 0.35, opacity: 0.3))
                        .clipShape(Circle().scale(0.90)).offset(y: 100)
                }
                .padding(.all)
            }
            .aspectRatio(1, contentMode: .fit)
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
                }
            }
        }
    }
    
    mutating func addPercent(newPercent: Int) {
        self.percent = newPercent
    }
}

struct WaterWaves: Shape {
    var offset: Angle
    var percent: Double
    
    var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let lowfudge = 0.02
        let highfudge = 0.98
        let newpercent = lowfudge + (highfudge - lowfudge) * percent
        let waveHeight = 0.015 * rect.height
        let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)
        p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}

