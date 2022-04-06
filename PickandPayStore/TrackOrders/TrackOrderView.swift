//
//  TrackOrderView.swift
//  PickandPayStore
//
//  Created by Ives Murillo on 4/5/22.
//

import SwiftUI
import MapKit

struct TrackOrderView: View {
    
  //  @StateObject private var trackViewModel: TrackOrderModel
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.6782, longitude: -73.9712), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                                              
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
    }
}

struct TrackOrderView_Previews: PreviewProvider {
    static var previews: some View {
        TrackOrderView()
    }
}
