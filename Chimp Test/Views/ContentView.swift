//
//  ContentView.swift
//  Chimp Test
//
//  Created by Alistair White on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showMain = false
    var body: some View {
        NavigationView {
            ZStack {
                Color("Steel Teal").ignoresSafeArea()
                VStack {
                    Group {
                        Image(systemName: "square.grid.3x3.topleft.filled")
                            .font(.system(size: 100)).bold()
                            .padding(.top, 200)
                        Text("Are You Smarter Than a Chimpanzee?")
                            .font(.largeTitle).bold()
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 20)
                    }
                    .foregroundColor(Color("Tea Green"))
                    Spacer()
                    NavigationLink {
                        MainView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .frame(width: 200, height: 75)
                                .foregroundColor(Color("Charcoal"))
                            Text("Play Game")
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
