//
//  SelectPaymentView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct SelectPaymentView: View {
    
    @Binding var paymentSelected: String
    @State var banckAccount = ""
    @State var show = false
    var body: some View {
        
        
        
        Form{
            
            
            Section(header: Text("Payment")){
                Menu("Select Payment"){
                    
                    
                    Button("COD"){
                        paymentSelected = "COD"
                    }
                        
                    Button("Net Banking"){
                        show.toggle()
                        paymentSelected = "net Banking"
                    }
                    
                }
                
                ApplePayButtonView(action: {})
                    .padding()
                
            }
            
            
            if show {
                TextField("Bank account",text: $banckAccount)
                    
                    
                    
            }
           
        
        }
    }
    
    func selectCod(){
      
    }
   /* func selectNetBanking(bankacc: Int){
        let banc = bankacc
        let bankAccount = TextField("Bank account",banc)
        
    }*/
}




/*struct SelectPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPaymentView(paymentSelected: $())
    }
}*/

