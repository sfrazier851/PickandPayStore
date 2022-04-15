//
//  SiteMenuView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/14/22.
//

import SwiftUI

struct SideMenuView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        //Set side menu color.
        ZStack (alignment: .topTrailing){
            
            Color(.init(gray: 0.7 , alpha: 0.5))
                .ignoresSafeArea()
            
            VStack {
                VStack {
                // Cell Views.
                HStack{
                    Button(action:{
                        PresenterManager.shared.show(vc: .register)
                        
                    }, label: {
                        Text("Register")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding()
                    })
                    Spacer()
                }
                HStack{
                    Button(action:{
                        PresenterManager.shared.show(vc: .login)                    },
                           label: {
                        Text("Log In")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding()
                    })
                    Spacer()
                }
            }
                
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
