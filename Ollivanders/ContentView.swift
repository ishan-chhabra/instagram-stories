//
//  ContentView.swift
//  Ollivanders
//
//  Created by Ishan Chhabra on 27/06/21.
//

import SwiftUI

fileprivate let wands: [Wand] = [
    Wand(name: "Dumbledore's Wand", stickerAsset: "dumbledore"),
    Wand(name: "Potter's Wand", stickerAsset: "potter"),
    Wand(name: "Granger's Wand", stickerAsset: "granger")
]

struct ContentView: View {

    var body: some View {
        NavigationView {
            List(wands, id: \.name){ wand in
                Text(wand.name)
            }
            .navigationBarTitle(Text("Ollivanders"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
