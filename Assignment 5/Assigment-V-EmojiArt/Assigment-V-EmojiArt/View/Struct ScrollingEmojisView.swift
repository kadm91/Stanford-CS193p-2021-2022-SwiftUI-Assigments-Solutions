//
//  Struct ScrollingEmojisView.swift
//  EmojiArt
//
//  Created by Kevin Martinez on 7/20/23.
//

import SwiftUI

struct ScrollingEmojisView: View {
    let emojis: String
    
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                       // .draggable(emoji)
                        .onDrag { NSItemProvider (object: emoji as NSString) } //old way to drag for iOS 16 new way is above
                }
            }
        }
    }
}


struct ScrollingEmojisView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingEmojisView(emojis: testEmojis)
    }
}
