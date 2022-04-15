//
//  MenuButton.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/14/22.
//

import SwiftUI

struct MenuButton: View {

    @Binding var isOpen: Bool
    
    var body: some View {
        if isOpen
        {
            Image(systemName: "xmark")
                .foregroundColor(.black)
        }
        else
        {
            Image(systemName: "line.3.horizontal")
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(isOpen: .constant(false))
    }
}
