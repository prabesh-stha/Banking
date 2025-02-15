//
//  HomeView.swift
//  Banking
//
//  Created by Prabesh Shrestha on 05/02/2025.
//

import SwiftUI

struct HomeView: View {
    let userId: String
    @StateObject private var viewModel: HomeViewModel
    init(userId: String) {
        self.userId = userId
        _viewModel = StateObject(wrappedValue: HomeViewModel(userManager: UserManager(), accountManager: AccountManager()))
    }
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("\(viewModel.salute),")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 5)
                    if let user = viewModel.user{
                        Text("\(Utility.capitalizeFirstLetter(of: user.firstName) ?? "unknown") \(Utility.capitalizeFirstLetter(of: user.middleName) ?? "") \(Utility.capitalizeFirstLetter(of: user.lastName) ?? "unknown")")
                                .foregroundStyle(Color.white)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                VStack(alignment: .leading){
                    if let account = viewModel.account{
                        Text("\(Utility.capitalizeFirstLetter(of: account.accountType) ?? "Unknown")")
                            .padding(.bottom, 7.5)
                            .foregroundStyle(Color.white)
                        Text("\(account.accountNo)")
                            .padding(.bottom, 7.5)
                            .foregroundStyle(Color.white)
                        
                        HStack{
                            Text("Balance:")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                            let result = viewModel.getCountryCurrency(from: account.country)
                            Text("\(result) \(Utility.formattedAmount(amount: account.amount))")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.white)
                            
                        }
                        .padding(.bottom)

                    }
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
            LazyVGrid(columns: viewModel.column, spacing: 10) {
                NavigationLink {
                    TransferMoneyView(userId: userId)
                } label: {
                    VStack(alignment: .center) {
                        ZStack{
                            Image(systemName: "arrowshape.up")
                                .offset(y: -15)
                            Image(systemName: "banknote")
                            
                        }
                        .foregroundStyle(Color.teal)
                        Text("Send Money")
                    }
                    .font(.caption)
                    .frame(width: 50, height: 70)
                    .padding()
                    .foregroundStyle(Color.primary)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                }
                
                NavigationLink {
                    Text("Statement")
                } label: {
                    VStack(alignment: .center) {
                            Image(systemName: "list.bullet.circle")
                        .foregroundStyle(Color.teal)
                        Text("Statement")
                    }
                    .font(.caption)
                    .frame(width: 50, height: 70)
                    .padding()
                    .foregroundStyle(Color.primary)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                }
                
                NavigationLink {
                    Text("Account")
                } label: {
                    VStack(alignment: .center) {
                            Image(systemName: "a.circle")
                            .frame(width: 25, height: 25, alignment: .centerFirstTextBaseline)
                        .foregroundStyle(Color.teal)
                        Text("Account")
                    }
                    .font(.caption)
                    .frame(width: 50, height: 70)
                    .padding()
                    .foregroundStyle(Color.primary)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    
                }
                
                NavigationLink {
                    Text("Profile")
                } label: {
                    VStack(alignment: .center) {
                        Image(systemName: "person.circle")
                        .foregroundStyle(Color.teal)
                        .frame(width: 25, height: 25, alignment: .centerFirstTextBaseline)
                        Text("Profile")
                    }
                    .font(.caption)
                    .frame(width: 50, height: 70)
                    .padding()
                    .foregroundStyle(Color.primary)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    
                }

            }.padding()
            .onAppear(perform: {
                print(userId)
//                viewModel.saveUser(userId: userId)
                viewModel.getUsers(userId: userId)
                viewModel.getAccount(userId: userId)
                
            })
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack{
        HomeView(userId: "")
    }
}
