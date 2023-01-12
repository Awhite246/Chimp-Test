//
//  Main.swift
//  Chimp Test
//
//  Created by Alistair White on 1/12/23.
//

import SwiftUI

struct MainView: View {
    @State var currNum = 1
    @State var currMax = 5
    //Used to keep track of how many loses there has been
    @State var lose = 0
    //Used to choose random color palate from colorset
    @State var colorNum = 10
    //Array to hold column setup
    let columns = [GridItem(.flexible()),  GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    //Array of arrays of colors
    //each nested array holds a color set
    //Order goes light, middle, dark
    let colorSet = [[Color("Tea Green"), Color("Steel Teal"), Color("Charcoal")],
    [Color("Pale Spring Bud"), Color("Tumbleweed"), Color("Black Coffee")],
    [Color("Misty Rose"), Color("French Lilac"), Color("Dark Purple")],
    [Color("Ash Gray"), Color("Xanadu"), Color("Rose Ebony")],
    [Color("Ivory"), Color("Cinnabar"), Color("Onyx")],
    [Color("Terra Cotta"), Color("Independence"), Color("Eggshell")],
    [Color("Maize Crayola"), Color("Persian Green"), Color("Charcoal")],
    [Color("Maximum Blue Purple"), Color("Medium Purple"), Color("Ghost White")],
    [Color("Orange Yellow Crayola"), Color("Indigo Dye"), Color("Lemon Meringue")],
    [Color("Cornsilk"), Color("Desert Sand"), Color("Tumbleweed 2")],
    [Color("Cinnamon Satin"), Color("Carolina Blue"), Color("Ivory")]]
    //Creates a list of buttons from 1 - 30 using .map
    @State var buttonList = (1...40).map { ChimpButton(num: $0, hidden: ($0 < 5) ? false : true)}
    var body: some View {
        ZStack {
            colorSet[colorNum][1].ignoresSafeArea()
            VStack {
                Text("Chimp Test Memory Game")
                    .font(.title).bold()
                    .foregroundColor(colorSet[colorNum][2])
                    .shadow(color: colorSet[colorNum][0], radius: 5)
                    .padding(.top, 20)
                Spacer()
                LazyVGrid(columns: columns) {
                    ForEach(0..<buttonList.count, id: \.self) { num in
                        Button {
                            //if last number randomize and add button
                            if currNum == currMax {
                                currMax += 1
                                currMax %= buttonList.count
                                currNum = 1
                                randomizeList()
                            }
                            //if wrong number reset
                            else if buttonList[num].num != currNum {
                                resetButtons()
                            }
                            //if right number hide button
                            else {
                                buttonList[num].toggle()
                                currNum += 1
                            }
                        } label: {
                            ZStack {
                                //box and text of number
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 68, height: 68)
                                    .foregroundColor(buttonList[num].hidden ? .clear : colorSet[colorNum][0])
                                Text("\(buttonList[num].num)")
                                    .foregroundColor((buttonList[num].hidden || (currNum > 1 && currMax > 5)) ? .clear : colorSet[colorNum][2])
                                    .font(.title).bold()
                                    .shadow(color: (buttonList[num].hidden || (currNum > 1 && currMax > 5)) ? .clear : colorSet[colorNum][1], radius: 0.5)
                            }
                            
                        }
                        .disabled(buttonList[num].hidden)
                        .padding(.bottom, -2)
                        .padding(.horizontal, 4)
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            randomizeList()
        }
    }
    //randomizes buttonList and hides and shows numbers based on if they are less than max num
    func randomizeList() {
        buttonList.shuffle()
        updateButtons()
    }
    func resetButtons() {
        lose += 1
        currNum = 1
        colorNum = Int.random(in: 0...10)
        randomizeList()
    }
    func updateButtons() {
        for i in 0..<buttonList.count {
            if buttonList[i].num <= currMax {
                buttonList[i].hidden = false
            } else {
                buttonList[i].hidden = true
            }
        }
    }
}
//stores number and hidden state
struct ChimpButton : Hashable {
    let id = UUID()
    let num : Int
    var hidden : Bool
    
    mutating func toggle() {
        hidden.toggle()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
