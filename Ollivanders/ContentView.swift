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
    
    func shareToInstagramStories(
        stickerImage: String,
        backgroundTopColor: String = "#7F0909",
        backgroundBottomColor: String = "#303030"
    ) {
        // 1. Get a data object of our UIImage...
        let stickerImageData = UIImage(named: stickerImage)?.pngData()
        
        // 2. Verify if we are able to open instagram-stories URL schema.
        // If we are able to, let's add our Sticker image to UIPasteboard.
        
        let urlScheme = URL(string: "instagram-stories://share?source_application=\(Bundle.main.bundleIdentifier ?? "")")
        
        if let urlScheme = urlScheme {
            if UIApplication.shared.canOpenURL(urlScheme) {
                
                var pasteboardItems: [[String : Any]]? = nil
                if let stickerImageData = stickerImageData {
                    pasteboardItems = [
                        [
                            "com.instagram.sharedSticker.stickerImage": stickerImageData,
                            "com.instagram.sharedSticker.backgroundTopColor": backgroundTopColor,
                            "com.instagram.sharedSticker.backgroundBottomColor": backgroundBottomColor
                        ]
                    ]
                }
                
                // We'll expire these pasteboard items in 5 minutes...
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)
                ]
                
                if let pasteboardItems = pasteboardItems {
                    UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
                }
                
                // 3. Try opening the URL...
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            } else {
                // App may not be installed. Handle those errors here...
                print("Something went wrong. Maybe Instagram is not installed on this device?")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(wands, id: \.name){ wand in
                Text(wand.name).onTapGesture {
                    shareToInstagramStories(stickerImage: wand.stickerAsset)
                }
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
