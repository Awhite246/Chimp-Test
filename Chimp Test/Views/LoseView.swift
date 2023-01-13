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
        VStack {
            Text("Lose View")
        }
    }
}
struct LoseView_Previews: PreviewProvider {
    static var previews: some View {
        LoseView(colorBack: Color("Steel Teal"), colorMiddle: Color("Tea Green"), colorFront: Color("Charcoal"), loseCount: 1, buttonCount: 7)
    }
}
