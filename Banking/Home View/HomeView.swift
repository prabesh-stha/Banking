//
//  HomeView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 05/02/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("\(viewModel.salute),")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 5)
                    Text("Prabesh Shrestha")
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                VStack(alignment: .leading){
                    Text("Account Type")
                        .padding(.bottom, 7.5)
                        .foregroundStyle(Color.white)
                    Text("4729156382047513")
                        .padding(.bottom, 7.5)
                        .foregroundStyle(Color.white)
                    
                    HStack{
                        Text("Balance:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                        let result = viewModel.getCountryCurrency(from: "United States")
                            Text("\(result) 12345")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                        
                    }
                    .padding(.bottom)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            .background(
                ZStack{
                    Image("home")
                        .resizable()
                        .scaledToFill()
                    Color.blue
                        .opacity(0.5)
                }
                    
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            LazyVGrid(columns: viewModel.column) {
                ForEach(1...8, id: \.self) { index in
                                    Text("Item \(index)")
                                        .frame(width: 90, height: 100)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        
                                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
