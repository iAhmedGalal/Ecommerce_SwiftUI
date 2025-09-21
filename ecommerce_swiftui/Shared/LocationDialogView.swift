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
    @Binding var selectedAddress: String
    @Binding var isPresented: Bool
    
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
                            Marker("موقعي", coordinate: userCoord)
                                .tint(.blue)
                        }
                        
                        if let coordinate = selectedCoordinate {
                            Marker("", coordinate: coordinate)
                        }
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                let tapPoint = value.location
                                if let mapCoordinate = proxy.convert(tapPoint, from: .local) {
                                    selectedCoordinate = mapCoordinate
                                    reverseGeocodeLocation(mapCoordinate)
                                    
                                    withAnimation {
                                        region = MKCoordinateRegion(
                                            center: CLLocationCoordinate2D(
                                                latitude: selectedCoordinate?.latitude ?? 0.0,
                                                longitude: selectedCoordinate?.longitude ?? 0.0
                                            ),
                                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                        )
                                    }
                                }
                            }
                        
                        
                    )
                }
                .frame(height: 275)
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

            Text(selectedAddress.isEmpty ? "اختر موقعًا على الخريطة" : selectedAddress)
                .font(.jfFont(size: 18))
                .lineLimit(2)
                .padding(8)
            
            ColoredButton(
                title: "Choose",
                isGrediant: true
            ) {
                isPresented = false
            }
            .padding(.top, 8)
        }
        .onAppear {
            LocationManager.shared.requestLocation { coordinate in
                userCoordinate = coordinate
                
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: userCoordinate?.latitude ?? 0.0,
                        longitude: userCoordinate?.longitude ?? 0.0
                    ),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
        }
    }
        
    private func reverseGeocodeLocation(_ coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                selectedAddress = [
                    placemark.name,
                    placemark.locality,
                    placemark.country
                ].compactMap { $0 }.joined(separator: ", ")
            }
        }
    }
}
