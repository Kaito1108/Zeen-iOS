//
//  PostView.swift
//  Zenn
//
//  Created by kaito on 2024/04/11.
//

import SwiftUI

struct PostView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State var Post: Post
    
    var body: some View {
        VStack{
            VStack{
                Text(Post.Emoji).font(.system(size: 60)).frame(width: 100, height: 100).background(Color.white).cornerRadius(5).shadow(radius: 5).padding()
                Spacer()
                Text(Post.Title).fontWeight(.bold).foregroundColor(Color.white)
                Spacer()
            }.frame(width: 250, height: 280).background(colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3)).cornerRadius(10).padding()
        }
    }
}

#Preview {
    PostView(Post: Post(Path: "", Emoji: "", Title: ""))
}
