//
//  SelectedEmojiView.swift
//  Assigment-V-EmojiArt
//
//  Created by Kevin Martinez on 7/27/23.
//

import SwiftUI


// TODO: create action variable for delete, add animation for delete in the contend view or document view


struct SelectionEffect: ViewModifier {
    
    var emoji: EmojiArtModel.Emoji
    var selectedEmojis: Set<EmojiArtModel.Emoji>
    var showDeleteButtoms: Bool
    var deleteAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            .overlay {
                
                if selectedEmojis.contains(emoji) {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(style: StrokeStyle (lineWidth: 3,dash: [5]))
                        .foregroundColor(.accentColor)
                        .overlay (alignment: .topTrailing){
                            if showDeleteButtoms {
                                Button (action: deleteAction) {
                                    
                                    Image(systemName: "trash.circle.fill")
                                        .background(Color.white)
                                        .font(.title3)
                                    //.fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .clipShape(Circle())
                                    
                                    
                                }
                                .offset(CGSize(width: 10, height: -10 ))
                            }
                        }
                    
                    
                    
                    
              // can use code below to add a cancel delete edit mode for this an action will need to be pass as a variable i: () -> Void, just like we did for the delete.
                    
//                        .overlay (alignment: .topLeading){
//                            if showDeleteButtoms {
//                                Button (action: {
//
//
//
//                                }) {
//
//                                    Image(systemName: "x.circle.fill")
//                                        .background(Color.white)
//                                        .font(.title3)
//                                    //.fontWeight(.bold)
//                                        .foregroundColor(.gray)
//                                        .clipShape(Circle())
//
//
//                                }
//                                .offset(CGSize(width: -9, height: -10 ))
//                            }
//                        }
                }
            }
    }
    
    
}

extension View {
    func selectionEffect(for emoji: EmojiArtModel.Emoji, in selectedEmojis: Set<EmojiArtModel.Emoji>, ShowDelete: Bool, deleteAction: @escaping ()-> Void) -> some View {
        modifier(SelectionEffect(emoji: emoji, selectedEmojis: selectedEmojis, showDeleteButtoms: ShowDelete, deleteAction: deleteAction))
    }
    
}

//                selectedEmojis.contains(emoji) ? RoundedRectangle(cornerRadius: 10).strokeBorder(style: StrokeStyle (lineWidth: 3, dash: [5])).foregroundColor(.accentColor) : nil
