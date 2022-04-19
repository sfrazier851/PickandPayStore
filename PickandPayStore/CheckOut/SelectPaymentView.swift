//
//  SelectPaymentView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/18/22.
//

import SwiftUI

struct SelectPaymentView: View {
    var body: some View {
        Menu("Select Payment"){
            Button("COD", action: selectCod)
                
            Button("Net Banking", action: selectNetBanking)
        }
    }
    
    func selectCod(){}
    func selectNetBanking(){}
}

struct SelectPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPaymentView()
    }
}
