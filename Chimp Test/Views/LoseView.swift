//
//  LoseView.swift
//  Chimp Test
//
//  Created by Alistair White on 1/12/23.
//

import SwiftUI

struct LoseView: View {
    //3 colors based on layering order
    let colorBack : Color
    let colorMiddle : Color
    let colorFront : Color
    let loseCount : Int
    let buttonCount : Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            colorBack.ignoresSafeArea()
            VStack {
                //Continue Screen
                if (loseCount < 3) {
                    Group {
                        Text("Numbers")
                            .font(.system(size: 35)).bold()
                            .padding(.top, 150)
                        Text("\(buttonCount)")
                            .font(.system(size: 100)).bold()
                            .padding(.bottom, 30)
                        Text("Strikes")
                            .font(.largeTitle)
                            .padding(.bottom, 10)
                        HStack {
                            //shows the correct amount of lose squares
                            ForEach (0..<loseCount, id: \.self) { _ in
                                Image(systemName: "square.split.diagonal.2x2")
                            }
                            ForEach (0..<(3-loseCount), id: \.self) { _ in
                                Image(systemName: "square")
                            }
                        }
                        .font(.system(size: 50)).bold()
                    }
                    .foregroundColor(colorMiddle)
                    
                } else {
                    //lose screen
                    Group {
                        Image(systemName: "square.grid.3x3.topleft.filled")
                            .font(.system(size: 75)).bold()
                            .padding(.top, 130)
                        Text("Score")
                            .font(.largeTitle).bold()
                            .padding(.top, 50)
                        Text("\(buttonCount)")
                            .font(.system(size: 100)).bold()
                        Text(buttonCount < 10 ? "You Are Not Smarter Than A Chimpanzee" : "You Are Smarter Than A Chimpanzee")
                            .frame(width: 200)
                            .multilineTextAlignment(.center)
                            .font(.title3).bold()
                            .padding(.top, -20)
                            .padding(.bottom, 30)
                    }
                    .foregroundColor(colorMiddle)
                }
                Spacer()
                //return to game button
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack{
                        
                        RoundedRectangle(cornerRadius:10)
                            .frame(width: 200, height: 75)
                            .foregroundColor(colorFront)
                        Text(loseCount < 3 ? "Continue" : "Try Again")
                            .font(.title2).bold()
                            .foregroundColor(colorMiddle)
                    }
                }
            }
            
        }
    }
}

struct LoseView_Previews: PreviewProvider {
    static var previews: some View {
        LoseView(colorBack: Color("Steel Teal"), colorMiddle: Color("Tea Green"), colorFront: Color("Charcoal"), loseCount: 3, buttonCount: 30)
    }
}
