//
//  View+Extension.swift
//  CoffeOrderApp
//
//  Created by wonki on 2023/02/25.
//

import Foundation
import SwiftUI

extension View {
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }

    @ViewBuilder
    func visible(_ value: Bool) -> some View {
        switch value {
        case true:
            self
        case false:
            EmptyView()
        }
    }
}
