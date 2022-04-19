//
//  SelectPaymentView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct SelectPaymentView: View {
   
    @State var banckAccount = ""
    @State var show = false
    var body: some View {
        
        
        
        Form{
            
            
            Section(header: Text("Payment")){
                Menu("Select Payment"){
                    
                    
                    Button("COD", action: selectCod)
                        
                    Button("Net Banking"){
                        show.toggle()
                        
                    }
                    
                }
                
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

struct SelectPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPaymentView()
    }
}
