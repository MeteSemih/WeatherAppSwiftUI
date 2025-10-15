//
//  SearchBarView.swift
//  WeatherApp
//
//  Created by Mete Semih Özlek on 16.10.2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var cityName : String
    let onSearch : () -> Void
    var body: some View {
        HStack{
        TextField("Search", text: $cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.words)
                .onSubmit {
                    onSearch()
                }
            
            Button(action:onSearch) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.blue.opacity(0.7))
                    .clipShape(Circle())
            }
            
        }
        .padding()
    }
}

#Preview {
    SearchBarView(cityName: .constant("İstanbul")) {
        print("Tıklandı")
    }
}
