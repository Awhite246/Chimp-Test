//
//  ContentView.swift
//  Chimp Test
//
//  Created by Alistair White on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showMain = false
    //Array of arrays of color, each nested array holds a color set, Order goes buttonColor, background, textColor
    let colorSet = [[Color("Tea Green"), Color("Steel Teal"), Color("Charcoal")],
                    [Color("Pale Spring Bud"), Color("Tumbleweed"), Color("Black Coffee")],
                    [Color("Misty Rose"), Color("French Lilac"), Color("Dark Purple")],
                    [Color("Ash Gray"), Color("Xanadu"), Color("Rose Ebony")],
                    [Color("Beige"), Color("Cinnabar"), Color("Onyx")],
                    [Color("Terra Cotta"), Color("Independence"), Color("Eggshell")],
                    [Color("Maize Crayola"), Color("Persian Green"), Color("Charcoal")],
                    [Color("Maximum Blue Purple"), Color("Medium Purple"), Color("Ghost White")],
                    [Color("Paradise Pink"), Color("Indigo Dye"), Color("Lemon Meringue")]]
    @State var colorNum = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                colorSet[colorNum][1].ignoresSafeArea()
                VStack {
                    Group {
                        //app logo
                        Image(systemName: "square.grid.3x3.topleft.filled")
                            .font(.system(size: 100)).bold()
                            .padding(.top, 170)
                        //title
                        Text("Are You Smarter Than a Chimpanzee?")
                            .font(.largeTitle).bold()
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 20)
                    }
                    .foregroundColor(colorSet[colorNum][2])
                    Spacer()
                    //button to main game
                    NavigationLink {
                        MainGame(colorSet: colorSet)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .frame(width: 200, height: 75)
                                .foregroundColor(colorSet[colorNum][0])
                            Text("Main Game")
                                .font(.title2).bold()
                                .foregroundColor(colorSet[colorNum][2])
                        }
                    }
                    .padding(.bottom, 50)
                    //button to timer game / alt game
                    NavigationLink {
                        AltGame(colorSet: colorSet)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .frame(width: 250, height: 75)
                                .foregroundColor(colorSet[colorNum][0])
                            Text("Alternative Game")
                                .font(.title2).bold()
                                .foregroundColor(colorSet[colorNum][2])
                        }
                    }
                }
                .padding()
            }
        }
        //randomizes the color set used
        .onAppear {
            colorNum = Int.random(in: 0..<colorSet.count)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
