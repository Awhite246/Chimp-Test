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
    @State var text = "not pressed"
    @State var lose = false
    //Array to hold column setup
    let columns = [GridItem(.flexible()),  GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    //Creates a list of buttons from 1 - 30 using .map
    @State var buttonList = (1...40).map { ChimpButton(num: $0, hidden: ($0 < 5) ? false : true)}
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                Group {
                    Button("Randomize") {
                        randomizeList()
                        currNum = 1
                    }
                    .bold()
                    Text("currMax: \(currMax)")
                    Button("Add Button") {
                        currMax += 1
                        currMax %= buttonList.count
                        for i in 0..<buttonList.count {
                            if buttonList[i].num <= currMax {
                                buttonList[i].hidden = false
                            }
                        }
                    }
                    .bold()
                    Text("currNum: \(currNum)")
                    Button("Reset") {
                        currMax = 5
                        currNum = 1
                        randomizeList()
                    }
                    .bold()
                }
                .foregroundColor(.white)
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
                                currNum = 1
                                randomizeList()
                            }
                            //if right number hide button
                            else {
                                buttonList[num].toggle()
                                currNum += 1
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 68, height: 68)
                                    .foregroundColor(buttonList[num].hidden ? .clear : .red)
                                Text("\(buttonList[num].num)")
                                    .foregroundColor((buttonList[num].hidden || (currNum > 1 && currMax > 5)) ? .clear : .black)
                                    .font(.title).bold()
                            }
                            
                        }
                        .disabled(buttonList[num].hidden)
                        .padding(.bottom, -2)
                    }
                }
            }
        }
        .onAppear {
            randomizeList()
        }
    }
    //randomizes buttonList and hides and shows numbers based on if they are less than max num
    func randomizeList() {
        buttonList.shuffle()
        for i in 0..<buttonList.count {
            if buttonList[i].num <= currMax {
                buttonList[i].hidden = false
            } else {
                buttonList[i].hidden = true
            }
        }
    }
}

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
