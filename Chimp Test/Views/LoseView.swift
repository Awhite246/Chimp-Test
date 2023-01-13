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
    var body: some View {
        ZStack {
            colorFront.ignoresSafeArea()
            VStack {
                Text("Are You Smarter Than a Chimpanzee?")
                    .font(.largeTitle).bold()
                    .foregroundColor(colorMiddle)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                Text("Click the squares in order according to their numbers.\n The test will get progressively harder")
                    .font(.title2).bold()
                    .foregroundColor(colorMiddle)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                Text("This is a test of working memory, made famous by a study that found that chimpanzees consistently outperform humans on this task.\n\n In the study, the chimps consistently outperformed humans, and some chimps were able to remember 9 digits over 90% of the time.\n\n This test is a variant of that concept, that gets increasingly difficult every turn, starting at 4 digits, and adding one every turn. If you pass a level, the number increases. If you fail, you get a strike. Three strikes and the test is over.")
                    .font(.title3)
                    .foregroundColor(colorMiddle)
                    .padding(.horizontal, 10)
                Spacer()
            }
        }
    }
}
struct LoseView_Previews: PreviewProvider {
    static var previews: some View {
        LoseView(colorBack: Color("Steel Teal"), colorMiddle: Color("Tea Green"), colorFront: Color("Charcoal"))
    }
}
