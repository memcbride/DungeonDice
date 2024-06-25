//
//  ContentView.swift
//  DungeonDice
//
//  Created by Mark McBride on 6/25/24.
//

import SwiftUI

struct ContentView: View {
    
    enum Dice: Int {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var resultMessage = ""
 
    var body: some View {
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.red)
            
            Spacer()
            
            Text(resultMessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(height: 150)
            
            Spacer()
            
            Group {
                HStack {
                    Button("\(Dice.four)-sided") {
                        resultMessage = "You rolled a \(Dice.four.roll()) \non a \(Dice.four.rawValue)-sided die"
                    }
                    Spacer()
                    Button("\(Dice.six)-sided") {
                        resultMessage = "You rolled a \(Dice.six.roll()) \non a \(Dice.six.rawValue)-sided die"
                    }
                    Spacer()
                    Button("\(Dice.eight)-sided") {
                        resultMessage = "You rolled a \(Dice.eight.roll()) \non a \(Dice.eight.rawValue)-sided die"
                    }
                }
                HStack {
                    Button("\(Dice.ten)-sided") {
                        resultMessage = "You rolled a \(Dice.ten.roll()) \non a \(Dice.ten.rawValue)-sided die"
                    }
                    Button("\(Dice.twelve)-sided") {
                        resultMessage = "You rolled a \(Dice.twelve.roll()) \non a \(Dice.twelve.rawValue)-sided die"
                    }
                    Spacer()
                    Button("\(Dice.twenty)-sided") {
                        resultMessage = "You rolled a \(Dice.twenty.roll()) \non a \(Dice.twenty.rawValue)-sided die"
                    }
                }
                Button("\(Dice.hundred)-sided") {
                    resultMessage = "You rolled a \(Dice.hundred.roll()) \non a \(Dice.hundred.rawValue)-sided die"
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
