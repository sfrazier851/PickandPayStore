//
//  AddReviewView.swift
//  PickandPayStore
//
//  Created by admin on 4/18/22.
//

import SwiftUI

struct AddReviewView: View {
    
    @State var fdbackTitle: String = ""
    @State var fdbackText: String = ""
    
    @Binding var reviews: [ProductReview]
    
    var productID: Int
    
    @Binding var showReview: Bool
    
    var body: some View {
        ZStack{
            Color(.init(gray: 0.7 , alpha: 0.5))
                .ignoresSafeArea()
            VStack{
                Text("Please Add Your Review")
                TextField("Add a Title", text: $fdbackTitle)
                    .background(Color.white)
                TextEditor(text: $fdbackText)
                
                Button{
                    reviews.append(ProductReview.create(userID: UserSessionManager.shared.getLoggedInUser()!.id, productID: productID, review: fdbackText)!)
                    
                    showReview.toggle()
                }
                label:{
                    Text("Submit")
                        .frame(width: 320, height: 20, alignment: .center)
                        .foregroundColor(.black)
                }
                .background(Color.gray)
                .cornerRadius(5)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView(reviews: .constant([]), productID: 1, showReview: .constant(true))
    }
}
