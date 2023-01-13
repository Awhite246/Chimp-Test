//
//  Main.swift
//  Chimp Test
//
//  Created by Alistair White on 1/12/23.
//

import SwiftUI

struct MainView: View {
    @State var currNum = 1
    @State var currMax = 4
    //Used to keep track of how many loses there has been
    @State var lose = 0
    //Used to choose random color palate from colorset
    @State var colorNum = 10
    //Stores weather to show lose and help view
    @State var showLoseView = false
    @State var showHelpView = false
    //Array to hold column setup
    let columns = [GridItem(.fixed(69)), GridItem(.fixed(69)), GridItem(.fixed(69)), GridItem(.fixed(69)), GridItem(.fixed(69))]
    //Array of arrays of color, each nested array holds a color set, Order goes buttonColor, background, textColor
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
            //creates background color using middle of color set
            colorSet[colorNum][1].ignoresSafeArea()
            VStack {
                let topBarSize = UIScreen.main.bounds.width / 7
                colorSet[colorNum][0]
                    .ignoresSafeArea()
                    .frame(height: topBarSize)
                    .overlay(
                        Group {
                            VStack {
                                Button {
                                    showHelpView = true
                                } label: {
                                    Image(systemName: "questionmark.circle")
                                        .resizable()
                                        .foregroundColor(colorSet[colorNum][2])
                                        .frame(width: 25, height: 25)
                                    
                                }
                                .padding(.top, -1 * (topBarSize))
                                //makes sure question mark stays on upper left while not going out of bounds on other phone versions
                                .offset(x: UIScreen.main.bounds.width / 2.75)
                                Text("Chimp Test Memory Game")
                                    .font(.title).bold()
                                    .foregroundColor(colorSet[colorNum][2])
                                    .padding(.top, -1 * (topBarSize / 2))
                            }
                        }
                    )
                LinearGradient(gradient: Gradient(colors: [colorSet[colorNum][0], Color.clear]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 15)
                    .padding(.top, -10)
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
                                //shows color if not disabled
                                    .foregroundColor(buttonList[num].hidden ? .clear : colorSet[colorNum][0])
                                Text("\(buttonList[num].num)")
                                //shows color if not disabled
                                    .foregroundColor((buttonList[num].hidden || (currNum > 1 && currMax > 4)) ? .clear : colorSet[colorNum][2])
                                    .font(.title).bold()
                            }
                            
                        }
                        .disabled(buttonList[num].hidden)
                        .padding(.bottom, -2)
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            randomizeList()
        }
        .sheet(isPresented: $showHelpView) {
            HelpView(colorBack: colorSet[colorNum][1], colorMiddle: colorSet[colorNum][0], colorFront: colorSet[colorNum][2])
        }
        .fullScreenCover(isPresented: $showLoseView) {
            LoseView(colorBack: colorSet[colorNum][1], colorMiddle: colorSet[colorNum][0], colorFront: colorSet[colorNum][2], loseCount: lose, buttonCount: currMax - 1)
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
