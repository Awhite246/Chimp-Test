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
                    [Color("Ivory"), Color("Cinnabar"), Color("Onyx")],
                    [Color("Terra Cotta"), Color("Independence"), Color("Eggshell")],
                    [Color("Maize Crayola"), Color("Persian Green"), Color("Charcoal")],
                    [Color("Maximum Blue Purple"), Color("Medium Purple"), Color("Ghost White")],
                    [Color("Paradise Pink"), Color("Indigo Dye"), Color("Lemon Meringue")],
                    [Color("Cornsilk"), Color("Desert Sand"), Color("Tumbleweed 2")],
                    [Color("Cinnamon Satin"), Color("Carolina Blue"), Color("Ivory")]]
    var body: some View {
        NavigationView {
            ZStack {
                Color("Steel Teal").ignoresSafeArea()
                VStack {
                    Group {
                        Image(systemName: "square.grid.3x3.topleft.filled")
                            .font(.system(size: 100)).bold()
                            .padding(.top, 170)
                        Text("Are You Smarter Than a Chimpanzee?")
                            .font(.largeTitle).bold()
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 20)
                    }
                    .foregroundColor(Color("Tea Green"))
                    Spacer()
                    NavigationLink {
                        MainGame(colorSet: colorSet)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .frame(width: 200, height: 75)
                                .foregroundColor(Color("Charcoal"))
                            Text("Main Game")
                                .font(.title2).bold()
                                .foregroundColor(Color("Tea Green"))
                        }
                    }
                    .padding(.bottom, 50)
                    NavigationLink {
                        AltGame(colorSet: colorSet)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .frame(width: 250, height: 75)
                                .foregroundColor(Color("Charcoal"))
                            Text("Alternative Game")
                                .font(.title2).bold()
                                .foregroundColor(Color("Tea Green"))
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
