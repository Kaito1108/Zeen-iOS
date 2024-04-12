//
//  ContentView.swift
//  Zenn
//
//  Created by kaito on 2024/04/11.
//

import SwiftUI
import WebKit
import Alamofire

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State var UserID: String
    
    @State var Posts: [Post] = []
    
    @State private var isLoading = false
    
    @State private var Showshould_LoginView = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: LoginView(), isActive: $Showshould_LoginView) {
                EmptyView()
            }
            HStack{
                Text("Zenn").font(.largeTitle).fontWeight(.bold).foregroundColor(Color.blue).padding()
                Spacer()
                Button(action: {
                    Showshould_LoginView = true
                }){
                    Text("Logout").font(.title2).fontWeight(.semibold).frame(width: 100, height: 55).background(Color.blue).foregroundColor(Color.white).cornerRadius(7)
                }.padding()
            }
            HStack{
                Text("投稿リスト").font(.title).fontWeight(.bold).foregroundColor(colorScheme == .dark ? Color.white : Color.black).padding()
                Spacer()
            }
            Spacer()
            if isLoading{
                LoadingView()
            } else {
                ScrollView{
                    ForEach(0..<Posts.count, id: \.self) { index in
                        NavigationLink(destination: WebView(url: URL(string: "https://zenn.dev/\(Posts[index].Path)")!)) {
                            PostView(Post: Posts[index])
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            FetchUserPost()
        }
    }
    private func FetchUserPost(){
        isLoading = true
        AF.request("https://zenn.dev/api/articles?username=\(UserID)&order=latest").responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let articles = json["articles"] as? [[String: Any]] {
                    // 記事の配列からタイトルを取得して表示
                    for article in articles {
                        if let title = article["title"] as? String,
                            let emoji = article["emoji"] as? String,
                            let path = article["path"] as? String{
                            Posts.append(Post(Path: path, Emoji: emoji, Title: title))
                        }
                    }
                    isLoading = false
                } else {
                    print("JSONデータの解析に失敗しました。")
                }
            case .failure(let error):
                print("リクエストエラー: \(error)")
            }
        }
    }
}

struct WebView: View {
    let url: URL

    var body: some View {
        WebViewContainer(url: url)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("", displayMode: .inline)
    }
}
struct WebViewContainer: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

#Preview {
    ContentView(UserID: "")
}
