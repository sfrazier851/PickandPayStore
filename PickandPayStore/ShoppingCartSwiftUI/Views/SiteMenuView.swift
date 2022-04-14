//
//  SiteMenuView.swift
//  PickandPayStore
//
//  Created by costin popescu on 4/14/22.
//

import SwiftUI

struct SiteMenuView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        //Set side menu color.
        ZStack (alignment: .topTrailing){
            
            Color(.init(gray: 0.7 , alpha: 0.5))
                .ignoresSafeArea()
            
            VStack {
                Button(action: {
                    withAnimation(.spring()) { isShowing.toggle() }
                }, label: {
                    Image(systemName: "xmark")
                        .frame(width: 35, height: 35)
                        .foregroundColor(.black)
                        .padding()
                })
            
            
            VStack {
                // Cell Views.
                HStack{
                   
                    Spacer()
                    }
                
                HStack{
                    
                    Spacer()
                    
                    }
            } .navigationBarHidden(true)
            }
        }
        
    }
}

struct SiteMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SiteMenuView(isShowing: .constant(true))
    }
}
