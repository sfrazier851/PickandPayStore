//
//  SwiftUIView.swift
//  PickandPayStore
//
//  Created by admin on 4/7/22.
//

import SwiftUI

struct SearchBar: View {
    
    //@State var searchText = ""
    @Binding var searchText: String
    @Binding var searching: Bool
    @Binding var pastSearches: [String]
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(Color("LightGray"))
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText){ startedEditing in
                        if startedEditing {
                            withAnimation{
                                searching = true
                            }
                        }
                    } onCommit: {
                        if searchText != "" && pastSearches.filter({ (search : String) -> Bool in
                            return searchText != search
                        }).count == pastSearches.count{
                            pastSearches.append(searchText)
                        }
                        
                        withAnimation{
                            searching = false
                            
                        }
                    }
                }
                .foregroundColor(.gray)
                .padding(.leading, 13)
                
            }
            .frame(height: 40)
            .cornerRadius(13)
            //.padding()
            .padding(.leading, 20)
            .padding(.trailing, 20)
            if searching{
                ForEach(pastSearches, id: \.self){ past in
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("LightGray"))
                        HStack{
                                Text(past).onTapGesture{
                                    searchText = past
                                    UIApplication.shared.dismissKeyboard()
                                    searching = false
                                }
                            }
                        .foregroundColor(.gray)
                        //.padding(.leading, 13)
                        
                    }
                    .frame(height: 40)
                    .cornerRadius(13)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                   
                }
            }
        }
    }
}

extension UIApplication{
    func dismissKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
