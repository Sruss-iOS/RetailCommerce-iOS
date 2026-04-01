//
//  OtpModifier.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 3/5/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Combine

struct OtpModifier: ViewModifier {
    
    @Binding var pin : String
    var textLimt = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }

    //MARK -> BODY
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: 45, height: 45)
            .background(.secondary)
            .cornerRadius(10)
    }
}
