//
//  waterView.swift
//  WaterMe
//
//  Created by Маркі on 10.12.2020.
//

import Foundation
import SwiftUI



struct WaterPercentView: View {
    var mililiters: Int
    let neededToDrink: Int
    
    @State private var waveOffset = Angle(degrees: 0)
    
    init(mililiters: Int, neededToDrink: Int) {
        self.mililiters = mililiters
        self.neededToDrink = neededToDrink
        checkDate()
    }
    
    var body: some View {
        GeometryReader { geometry in
            GeometryReader { geo in
                ZStack {
                    Text("\(calculatePercent())%")
                        .foregroundColor(.white)
                        .font(Font.system(size: 0.25 * min(geo.size.width, geo.size.height) )).offset(y: 100)
                    Text("\(mililiters) ml out of \(neededToDrink) ml")
                        .foregroundColor(.white)
                        .font(Font.system(size: 0.05 * min(geo.size.width, geo.size.height) )).offset(y: 160)
                    WaterWaves(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(calculatePercentInt())/100)
                        .fill(calculatePercentInt() < 100 ? Color(red: 0.58, green: 0.67, blue: 0.83, opacity: 0.3) : Color(red: 0.38, green: 0.69, blue: 0.35, opacity: 0.3))
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
    
    func calculatePercent() -> String {
        let percentInteger = Int((mililiters * 100) / neededToDrink)
        return String(percentInteger)
    }
    
    func calculatePercentInt() -> Int {
        return Int((mililiters * 100) / neededToDrink)
    }
    
    mutating func addMilimeters(newMilimeters: Int) {
        self.mililiters += newMilimeters
    }
}

func checkDate() {
    let date = Date()
    let calendar = Calendar.current
    let currentDay = calendar.component(.day, from: date)
    let currentMonth = calendar.component(.month, from: date)
    let lastLoginDay = UserDefaults.standard.integer(forKey: "LastLoginDay")
    let lastLoginMonth = UserDefaults.standard.integer(forKey: "LastLoginMonth")
    if currentMonth != lastLoginMonth {
        UserDefaults.standard.set(0, forKey: "AlreadyDrunk")
    }
    if currentDay != lastLoginDay {
        UserDefaults.standard.set(0, forKey: "AlreadyDrunk")
    }
    UserDefaults.standard.set(currentMonth, forKey: "LastLoginMonth")
    UserDefaults.standard.set(currentDay, forKey: "LastLoginDay")
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

