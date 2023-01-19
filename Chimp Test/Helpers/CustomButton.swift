//
//  CustomButton.swift
//  Chimp Test
//
//  Created by Alistair White on 1/17/23.
//

import Foundation
import SwiftUI

//stores number and hidden state
struct ChimpButton : Hashable {
    let id = UUID()
    //what number the buton is
    let num : Int
    //wether or not the button is hidden
    var hidden : Bool
    
    mutating func toggle() {
        hidden.toggle()
    }
}
