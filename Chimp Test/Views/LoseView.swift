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
                        HStack {
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
                    Spacer()
                    Button {
                        
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius:10)
                                .frame(width: 200, height: 75)
                                .foregroundColor(colorFront)
                            Text("Continue")
                                .font(.title2).bold()
                                .foregroundColor(colorMiddle)
                        }
                    }
                }
            }
            
        }
    }
}

struct LoseView_Previews: PreviewProvider {
    static var previews: some View {
        LoseView(colorBack: Color("Steel Teal"), colorMiddle: Color("Tea Green"), colorFront: Color("Charcoal"), loseCount: 1, buttonCount: 7)
    }
}
