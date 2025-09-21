//
//  RegisterView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 17/09/2025.
//

import SwiftUI
import MapKit

struct RegisterView: View {
    @Environment(Router.self) var router
    
    @StateObject private var viewModel = RegisterViewModel()
    @FocusState private var focusedField: String?
    
    var body: some View {
        ZStack {
            Color(AppColors.greyWhite)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Image(AppAssets.nameApp)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170)
                        .padding()
                    
                    IconTextField(
                        title: "Name",
                        placeHolder: "Name",
                        icon: AppAssets.user,
                        keyboardType: .namePhonePad,
                        text: $viewModel.nameTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Email",
                        placeHolder: "Email",
                        icon: AppAssets.mail,
                        keyboardType: .emailAddress,
                        text: $viewModel.mailTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Phone",
                        placeHolder: "Phone",
                        icon: AppAssets.phone,
                        keyboardType: .asciiCapableNumberPad,
                        text: $viewModel.phoneTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    

                    ZStack(alignment: .trailing) {
                        IconTextField(
                            title: "Address",
                            placeHolder: "Address",
                            icon: AppAssets.map,
                            text: $viewModel.addressTF,
                            focusedField: _focusedField
                        )
                        
                        Button {
                            viewModel.showMap = true
                        } label: {
                            Image(AppAssets.markerDown)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .padding(.horizontal, 28)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Password",
                        placeHolder: "Passwors",
                        icon: AppAssets.iconLock,
                        isPssword: true,
                        text: $viewModel.passwordTF,
                        focusedField: _focusedField
                    )
                    .padding(.bottom, 8)
                    
                    IconTextField(
                        title: "Confirm Password",
                        placeHolder: "Passwors",
                        icon: AppAssets.iconLock,
                        isPssword: true,
                        text: $viewModel.confirmPasswordTF,
                        focusedField: _focusedField
                    )
                    
                    HStack(spacing: 4) {
                        CheckBoxView(isChecked: $viewModel.acceptTerms)
                            .padding(.vertical, 16)
                            .padding(.leading, 16)
                            .padding(.trailing, 4)
                        
                        Text("Accept All")
                            .font(.jfFont(size: 18))
                        
                        Button {
                            
                        } label: {
                            Text("Terms and Conditions")
                                .font(.jfFont(size: 18))
                                .underline()
                        }
                        
                        Spacer()
                    }
                    
                    ColoredButton(title: "Creat Account", showArrow: false, isGrediant: true) {
                        viewModel.register()
                    }
                }
            }
            .toastView(toast: $viewModel.toast)
                
            .onChange(of: viewModel.navigateToLogin) { oldValue, newValue in
                if (newValue) {
                    router.push(.login)
                }
            }
//            .sheet(isPresented: $viewModel.showMap) {
//                LocationDialogView(
//                    selectedCoordinate: $viewModel.selectedCoordinate,
//                    selectedAddress: $viewModel.addressTF,
//                    isPresented: $viewModel.showMap
//                )
//                .presentationDetents([.height(400)])
//            }
            
            if viewModel.showMap {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showMap = false
                    }
                
                LocationDialogView(
                    selectedCoordinate: $viewModel.selectedCoordinate,
                    selectedAddress: $viewModel.addressTF,
                    isPresented: $viewModel.showMap
                )
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .padding()
                .transition(.scale)
            }
        }
    }
}

struct LocationDialogView: View {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var selectedAddress: String
    @Binding var isPresented: Bool
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357), // Cairo as default
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack(spacing: 16) {
            MapReader { proxy in
                Map(position: .constant(.region(region))) {
                    if let coordinate = selectedCoordinate {
                        Marker("الموقع المختار", coordinate: coordinate)
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            let tapPoint = value.location
                            if let mapCoordinate = proxy.convert(tapPoint, from: .local) {
                                selectedCoordinate = mapCoordinate
                                reverseGeocodeLocation(mapCoordinate)
                            }
                        }
                )
            }
            .frame(height: 250)
            .cornerRadius(12)

            Text(selectedAddress.isEmpty ? "اختر موقعًا على الخريطة" : selectedAddress)
                .font(.jfFont(size: 18))
                .padding(8)
            
            ColoredButton(
                title: "Choose",
                isGrediant: true
            ) {
                isPresented = false
            }
            .padding(.top, 8)
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

struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

#Preview {
    RegisterView()
}
