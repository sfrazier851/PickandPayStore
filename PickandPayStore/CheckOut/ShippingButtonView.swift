//
//  ShippingButtonView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct ShippingButtonView: View {
    
    @State var currentAddress: String = " "
    @State var postalCode: String = " "
    var body: some View {
        
        Menu("Shipping Address"){
            
            
                Button("Address 1"){
                    
                }
                Button("State"){
                    
                }
            
                Button("postal code"){
                }
                
            
        }
    }
}

struct ShippingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingButtonView()
    }
}
