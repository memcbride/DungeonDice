//
//  ButtonLayoutView.swift
//  DungeonDice
//
//  Created by Mark McBride on 6/26/24.
//

import SwiftUI

struct ButtonLayout: View {
    
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case fifty = 50
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    // A Preference key struct which we'll use to pass values up from child to parent View
    struct DeviceWithPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
        
        typealias Value = CGFloat
    }
    
    @State private var buttonsLeftOver = 0 // # of buttons in a less-than-full-row    @State private var deviceWidth: CGFloat
    @Binding var resultMessage: String
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 0 // between buttons
    let buttonWidth: CGFloat = 102
    
    var body: some View {

            VStack {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth),spacing: spacing)]) {
                    ForEach(Dice.allCases.dropLast(buttonsLeftOver), id: \.self) {die in
                        Button("\(die.rawValue)-sided") {
                            resultMessage = "You rolled a \(die.roll()) \non a \(die.rawValue)-sided die"
                        }
                        .frame(width: buttonWidth)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                
                HStack {
                    ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) { die in
                        Button("\(die.rawValue)-sided") {
                            resultMessage = "You rolled a \(die.roll()) \non a \(die.rawValue)-sided die"
                        }
                        .frame(width: buttonWidth)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            }
            .overlay {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: DeviceWithPreferenceKey.self, value: geo.size.width)
                }
            }
            .onPreferenceChange(DeviceWithPreferenceKey.self) { deviceWidth in
                arrangeGridItems(deviceWidth: deviceWidth)
            }
    }

    
    func arrangeGridItems(deviceWidth: CGFloat) {
        var screenWidth = deviceWidth - horizontalPadding*2  // padding on both sides
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        
        // calculate numOfButtonsPerRow as an Int
        let numberOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
        //        print("numberOfButtonsPerRow = \(numberOfButtonsPerRow)")
        //        print("buttonsLeftOver = \(buttonsLeftOver)")
    }
}

#Preview {
    ButtonLayout(resultMessage: .constant(""))
}
