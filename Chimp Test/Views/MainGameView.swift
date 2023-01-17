//
//  MainGameView.swift
//  Chimp Test
//
//  Created by Alistair White on 1/17/23.
//

import SwiftUI

struct MainGameView: View {
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
        Text("Hello, World!")
    }
}

struct MainGameView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView()
    }
}
