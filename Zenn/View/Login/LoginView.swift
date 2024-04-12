//
//  LoginView.swift
//  Zenn
//
//  Created by kaito on 2024/04/11.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State var UserID: String = ""
    @State private var Showshould_ContentView = false
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: ContentView(UserID: UserID), isActive: $Showshould_ContentView) {
                    EmptyView()
                }
                HStack{
                    Text("iOS").font(.title).fontWeight(.black).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    Text("Zenn").font(.system(size: 40)).fontWeight(.black).foregroundColor(Color.blue)
                }.padding()
                HStack{
                    Text("@").font(.largeTitle).fontWeight(.bold).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    TextField("", text: $UserID).frame(width: 300, height: 55).background(Color.gray).foregroundColor(colorScheme == .dark ? Color.black : Color.white).cornerRadius(3)
                }
                Button(action: {
                    Showshould_ContentView = true
                }){
                    Text("Login").font(.title3).fontWeight(.semibold).frame(width: 100, height: 50).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                }.padding()
            }
            //キーボードの閉じるボタン
            .toolbar{
                ToolbarItem(placement: .keyboard) {
                    Button("閉じる") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}
