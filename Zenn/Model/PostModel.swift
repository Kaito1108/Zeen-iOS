//
//  PostModel.swift
//  Zenn
//
//  Created by kaito on 2024/04/11.
//

import Foundation

struct Post: Identifiable{
    var id = UUID()
    var Path: String;
    var Emoji: String;
    var Title: String;
}
