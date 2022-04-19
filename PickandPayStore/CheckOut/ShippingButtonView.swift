//
//  ShippingButtonView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct ShippingButtonView: View {
    @State private var adress = ""
    @State private var postalCode = ""
    @State private var state = ""
    @State private var states = ["Ny","Fl","Tx","Cl","DA","CU"]
    
    var body: some View {
        
       
        Form{
            Section(header: Text("Shipping")){
                TextField("Adress", text: $adress)
                Picker("State", selection: $state){
                    
                    ForEach(states, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Postal code", text: $postalCode)
               
            }
           
        }
    }
}

struct ShippingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingButtonView()
    }
}
