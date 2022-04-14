//
//  SwiftUIView.swift
//  PickandPayStore
//
//  Created by admin on 4/7/22.
//

import SwiftUI
//Creates a searchbar with text field for searching through products
struct SearchBar: View {
    
    //Variables all bound to the given category or product list
    @Binding var searchText: String
    @Binding var searching: Bool
    @Binding var pastSearches: [String]
    
    var body: some View {
        VStack{
            ZStack{
                //Create rectangle for background of searchbar
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
                        //Adds search text to pastsearches array if it isn't already in the array
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
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            //If actively searching then show all past searches below searchbar
            if searching{
                ForEach(pastSearches, id: \.self){ past in
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("LightGray"))
                        HStack{
                                //When selecting a past search, set search text and dismiss keyboard
                                Text(past).onTapGesture{
                                    searchText = past
                                    UIApplication.shared.dismissKeyboard()
                                    searching = false
                                }
                            }
                        .foregroundColor(.gray)
                        
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

//Extension for dismissing the keyboard while searching and selecting a past search or cancel
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
