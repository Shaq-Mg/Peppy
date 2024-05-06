//
//  AlertBindingEst.swift
//  Peppy
//
//  Created by Shaquille McGregor on 06/05/2024.
//

import SwiftUI

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
