//
//  LocationDialogView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 21/09/2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationDialogView: View {
    @State var userCoordinate: CLLocationCoordinate2D?

    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var isPresented: Bool
    @Binding var selectedAddress: String
    
    @ObservedObject private var locationManager = LocationManager()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357), // Cairo as default
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                MapReader { proxy in
                    Map(position: .constant(.region(region))) {
                        if let userCoord = userCoordinate {
                            Marker("myLocation".tr(), coordinate: userCoord)
                                .tint(.blue)
                        }
                        
                        if let coordinate = selectedCoordinate {
                            Marker("", coordinate: coordinate)
                        }
                    }
                    .gesture(
                        TapGesture().onEnded({ point in
                            if let mapCoordinate = proxy.convert(, from: .local) {
                                selectedCoordinate = mapCoordinate
                                locationManager.reverseGeocodeLocation(mapCoordinate)
                                
                                withAnimation {
                                    region = MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(
                                            latitude: selectedCoordinate?.latitude ?? 0.0,
                                            longitude: selectedCoordinate?.longitude ?? 0.0
                                        ),
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                    )
                                    
                                    selectedAddress = locationManager.address.isEmpty ? "chooseLocationFromMap".tr() : locationManager.address
                                }
                            }
                        })
                    )
                    .onTapGesture {
                        let tapPoint = value

                    }
//                    .gesture(
//                        DragGesture(minimumDistance: 0)
//                            .onEnded { value in
//                                let tapPoint = value.location
//                                if let mapCoordinate = proxy.convert(tapPoint, from: .local) {
//                                    selectedCoordinate = mapCoordinate
//                                    locationManager.reverseGeocodeLocation(mapCoordinate)
//                                    
//                                    withAnimation {
//                                        region = MKCoordinateRegion(
//                                            center: CLLocationCoordinate2D(
//                                                latitude: selectedCoordinate?.latitude ?? 0.0,
//                                                longitude: selectedCoordinate?.longitude ?? 0.0
//                                            ),
//                                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//                                        )
//                                        
//                                        selectedAddress = locationManager.address.isEmpty ? "chooseLocationFromMap".tr() : locationManager.address
//                                    }
//                                }
//                            }
//                    )
                }
                .frame(height: 375)
                .cornerRadius(12, corners: [.topLeft, .topRight])
                
                Button {
                    region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: userCoordinate?.latitude ?? 0.0,
                            longitude: userCoordinate?.longitude ?? 0.0
                        ),
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                } label: {
                    Image(systemName: "location.app.fill")
                        .imageScale(.large)
                        .font(.largeTitle)
                        .frame(width: 30, height: 30)
                        .padding()
                }
            }

            Text(selectedAddress)
                .font(.jfFont(size: 18))
                .lineLimit(2)
                .padding(8)
            
            ColoredButton(
                title: "choose".tr(),
                isGrediant: true
            ) {
                isPresented = false
            }
            .padding(.top, 8)
        }
        .onAppear {
            userCoordinate = locationManager.locationCoordinate
            
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userCoordinate?.latitude ?? 0.0,
                    longitude: userCoordinate?.longitude ?? 0.0
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            
            selectedAddress = locationManager.address.isEmpty ? "chooseLocationFromMap".tr() : locationManager.address
        }
    }
}
