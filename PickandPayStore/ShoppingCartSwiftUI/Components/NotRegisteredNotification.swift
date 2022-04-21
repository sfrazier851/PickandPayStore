//
//  NotRegisteredNotification.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/18/22.
//

import SwiftUI

struct NotRegisteredNotification: View {
    var body: some View {
        
        ZStack{
            Color(.init(gray: 0.7, alpha: 0.9))
            
            VStack {
                
                Text("Log in to continue with your purchase")
                    .fontWeight(.heavy)
                    .foregroundColor(.red)
                
                HStack{
                    
                  /*  Button(action: {
                        PresenterManager.shared.show(vc: .login)
                    }, label: {
                        Text("Log In")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .padding()
                        
                    })
                    
                    Button(action: {
                        PresenterManager.shared.show(vc: .register)
                    }, label: {
                        Text("Register")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .padding()
                        
                    })*/
                    
                    NavigationLink(destination: UIKitRegister().navigationBarTitleDisplayMode(.inline)){
                        Text("Register")
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                            .padding()
                            
                    }
                    NavigationLink(destination: UIKitLogin().navigationBarTitleDisplayMode(.inline),
                           label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                            .padding()
                    })
                    
                }
                Spacer()
            }
            .padding()
        }
        .frame(height: UIScreen.main.bounds.height * 0.6)
        .transition(.slide)
        .animation(.easeInOut)
        
    }
}

struct NotRegisteredNotification_Previews: PreviewProvider {
    static var previews: some View {
        NotRegisteredNotification()
    }
}
