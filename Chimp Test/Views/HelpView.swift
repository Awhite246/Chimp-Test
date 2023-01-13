//
//  HelpView.swift
//  Chimp Test
//
//  Created by Alistair White on 1/12/23.
//

import SwiftUI

struct HelpView: View {
    //3 colors based on layering order
    let colorBack : Color
    let colorMiddle : Color
    let colorFront : Color
    var body: some View {
        Text("Help View")
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(colorBack: .white, colorMiddle: .blue, colorFront: .black)
    }
}
