//
//  MainGameView.swift
//  Chimp Test
//
//  Created by Alistair White on 1/17/23.
//

import SwiftUI

struct AltGame: View {
    //what button show be pressed next
    @State var currNum = 1
    //how many buttons displayed
    @State var currMax = 4
    //Used to keep track of how many loses there has been
    @State var lose = 0
    //triggers when timer reaches full
    @State var hideAll = false
    
    //Stores weather to show lose and help view
    @State var showLoseView = false
    @State var showHelpView = false
    
    //colors
    let colorSet : [[Color]]
    //Used to choose random color palate from colorset
    @State var colorNum = 0
    
    //Array to hold column setup
    let columns = [GridItem(.fixed(69)), GridItem(.fixed(69)), GridItem(.fixed(69)), GridItem(.fixed(69)), GridItem(.fixed(69))]
    //Creates a list of buttons from 1 - 30 using .map
    @State var buttonList = (1...40).map { ChimpButton(num: $0, hidden: ($0 < 5) ? false : true)}
    
    //timer / progress bar on top
    @State var progress = 0.0
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    @State var audioPlayer = AudioPlayer(fileNames: ["dNote", "lose"])
    
    //used for custom back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            ZStack {
                //creates background color using middle of color set
                colorSet[colorNum][1].ignoresSafeArea()
                VStack {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(maxWidth: 350, maxHeight: 4)
                            .foregroundColor(colorSet[colorNum][0])
                            .cornerRadius(10)
                        Rectangle()
                            .frame(width: progress * 350, height: 4)
                            .foregroundColor(colorSet[colorNum][2])
                            .cornerRadius(10)
                    }
                    .padding(.top, 25)
                    Spacer()
                    LazyVGrid(columns: columns) {
                        ForEach(0..<buttonList.count, id: \.self) { num in
                            Button {
                                if currNum == 1 {
                                    progress = 1.0
                                }
                                //if last number randomize and add button
                                if currNum == currMax {
                                    audioPlayer.playNote(pitch: -1000 + (Float((currNum + 1)) * 100.0), fileNum: 0)
                                    currMax += 1
                                    currMax %= buttonList.count
                                    currNum = 1
                                    randomizeList()
                                    progress = 0.0
                                    hideAll = false
                                }
                                //if wrong number reset
                                else if buttonList[num].num != currNum {
                                    audioPlayer.playNote(pitch: 0, fileNum: 1)
                                    showLoseView = true
                                }
                                //if right number hide button
                                else {
                                    buttonList[num].toggle()
                                    currNum += 1
                                    audioPlayer.playNote(pitch: -1000 + (Float(currNum) * 100.0), fileNum: 0)
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
                                        .foregroundColor((buttonList[num].hidden || (currNum > 1 && currMax > 4) || (currMax > 4 && hideAll)) ? .clear : colorSet[colorNum][2])
                                        .font(.title).bold()
                                }
                                
                            }
                            .disabled(buttonList[num].hidden)
                            .padding(.bottom, -2)
                        }
                    }
                    Spacer()
                    HStack {
                        //custom back button
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(colorSet[colorNum][0])
                                    .frame(width:70, height: 70)
                                Image(systemName: "restart.circle")
                                    .resizable()
                                    .foregroundColor(colorSet[colorNum][2])
                                    .frame(width: 25, height: 25)
                                    .offset(x: 10, y: -10)
                            }
                        }
                        .padding(.bottom, -50)
                        .offset(x: -1 * UIScreen.main.bounds.width / 2.8)
                        .ignoresSafeArea()
                        .opacity(0.5)
                        //help button
                        Button {
                            showHelpView = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(colorSet[colorNum][0])
                                    .frame(width:70, height: 70)
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .foregroundColor(colorSet[colorNum][2])
                                    .frame(width: 25, height: 25)
                                    .offset(x: -10, y: -10)
                            }
                        }
                        .padding(.bottom, -50)
                        .offset(x: UIScreen.main.bounds.width / 2.8)
                        .ignoresSafeArea()
                        .opacity(0.5)
                    }
                }
            }
        }
        .onAppear {
            randomizeList()
            //randomize color
            colorNum = Int.random(in: 0..<colorSet.count)
        }
        .sheet(isPresented: $showHelpView) {
            HelpView(colorBack: colorSet[colorNum][1], colorMiddle: colorSet[colorNum][0], colorFront: colorSet[colorNum][2])
        }
        .fullScreenCover(isPresented: $showLoseView, onDismiss: {
            lose += 1
            if lose == 3 {
                //makes sure you dont get repeat color palat in a row
                let tempColorNum = Int.random(in: 0..<colorSet.count)
                if colorNum != tempColorNum {
                    colorNum = tempColorNum
                } else {
                    colorNum += 1
                    colorNum %= colorSet.count
                }
                lose = 0
                currMax = 4
            }
            currNum = 1
            randomizeList()
            progress = 0
            hideAll = false
        }) {
            LoseView(colorBack: colorSet[colorNum][1], colorMiddle: colorSet[colorNum][0], colorFront: colorSet[colorNum][2], loseCount: lose + 1, buttonCount: currMax - 1)
        }
        .onReceive(timer) { _ in
            if progress < 0.9 {
                progress += 0.04 / Double(currMax)
            } else if progress < 1 {
                progress += 0.02 / Double(currMax)
            } else {
                hideAll = true
            }
        }
    }
    //randomizes buttonList and hides and shows numbers based on if they are less than max num
    func randomizeList() {
        buttonList.shuffle()
        updateButtons()
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

struct AltGame_Previews: PreviewProvider {
    static var previews: some View {
        AltGame(colorSet: [[Color("Tea Green"), Color("Steel Teal"), Color("Charcoal")]])
    }
}
