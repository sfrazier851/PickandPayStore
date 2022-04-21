//
//  SelectPaymentView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct SelectPaymentView: View {
    
    @Binding var paymentSelected: String
    @Binding var success: Bool
   
    @State var show = false
    @State var payment = "Select Payment"
    var body: some View {
            
            Section(header: Text("Payment")){
                Menu("\(payment)"){
                    
                    Button("COD"){
                        paymentSelected = "COD"
                        payment = "COD"
                        show = false
                       // Text("COD")
                    }
                    //button
                        
                    Button("Net Banking"){
                       // show.toggle()
                        paymentSelected = "net Banking"
                        payment = "Net Banking"
                        show = false
                    }
                    //button
                    Button("Apple pay"){
                        show.toggle()
                        paymentSelected = "Apple pay"
                    }
                }
                //menu
                
            }
    
            if show {
               // TextField("Bank account",text: $banckAccount)
                    
                ApplePayButtonView(action: CartManager.sharedCart.pay, success: $success)
                    .padding()
                    
            }else{
               // Text("\(payment)")
                
            }
           
    }
    
  
}




/*struct SelectPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPaymentView(paymentSelected: $())
    }
}*/

