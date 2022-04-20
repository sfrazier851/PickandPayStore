//
//  SiteMenuView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/14/22.
//

import SwiftUI
import UIKit

struct SideMenuView: View {
    
    @State var isLogged: Bool = UserSessionManager.shared.isLoggedIn()
    
    @Binding var isShowing: Bool
    
    

    var body: some View {
        //Set side menu color.
       // UITableView.appearance().backgroundColor = .clear
        ZStack (alignment: .topLeading){
            
            Color(.init(gray: 0.7 , alpha: 0.5))
                .ignoresSafeArea()
            
            if isLogged
            {
                List{
                    
                    Text("\(UserSessionManager.shared.getUserName())")
                         .fontWeight(.semibold)
                         .foregroundColor(.black)
                         .padding()
                    
                   
                    
                    NavigationLink( destination: WishlistView()){
                        Text("Wish List")
                             .fontWeight(.semibold)
                             .foregroundColor(.black)
                             .padding()
                             
                        
                    }
                    
                    NavigationLink( destination: PastOrdersView()){
                        Text("Past Orders")
                             .fontWeight(.semibold)
                             .foregroundColor(.black)
                             .padding()
                             
                        
                    }
                    
                    Text("Log Out")
                         .fontWeight(.semibold)
                         .foregroundColor(.black)
                         .padding()
                         .onTapGesture {
                             UserSessionManager.shared.setLoggedInFalse()
                             PresenterManager.shared.show(vc: .shop)
                            }
                }
                .frame(width: 200)
            }
            else
            {
            
                List{
//                    Button(action:{
//                        PresenterManager.shared.show(vc: .register)
//
//                    }, label: {
//                        Text("Register")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.black)
//                            .padding()
//                    })
                    NavigationLink(destination: UIKitRegister().navigationBarTitleDisplayMode(.inline)){
                        Text("Register")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding()
                            
                    }
                    NavigationLink(destination: UIKitLogin().navigationBarTitleDisplayMode(.inline),
                           label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding()
                    })
                    
//                    Button(action:{
//                        PresenterManager.shared.show(vc: .login)                    },
//                           label: {
//                        Text("Log In")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.black)
//                            .padding()
//                    })
                    
                    NavigationLink(destination: WishlistView(),
                           label: {
                        Text("Wishlist")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding()
                    })
                }
                .frame(width: 200)
            }
        }
        .onAppear(){
            UITableView.appearance().backgroundColor = .clear
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        SideMenuView(isShowing: .constant(true))
        }
        
    }
}
