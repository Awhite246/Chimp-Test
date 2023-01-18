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
        ZStack {
            colorBack.ignoresSafeArea()
            VStack {
                Group {
                    Text("Are You Smarter Than a Chimpanzee?")
                        .font(.largeTitle).bold()
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 20)
                    Text("Click the squares in order according to their numbers.\n The test will get progressively harder")
                        .font(.title2).bold()
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                    Text("This test will measure your working memory ability, which was found to be higher in chimpanzees than in humans in a study. Some of the chimps in the study were even able to remember 9 digits with a 90% accuracy. \n\nThis test is based on that concept, but it will become more difficult with each round, starting with 4 digits and adding one more each time. \n\nIf you are successful, the number of digits will increase, but if you fail, you will receive a strike. If you receive three strikes, the test will end.")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                }
                .foregroundColor(colorMiddle)
                Spacer()
                Text("Swipe down to close")
                    .foregroundColor(colorFront)
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(colorBack: .white, colorMiddle: .blue, colorFront: .black)
    }
}
