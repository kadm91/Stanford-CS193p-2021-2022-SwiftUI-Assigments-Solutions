//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Kevin Martinez on 7/20/23.
//

import SwiftUI

let testEmojis = "🤨🙁🐫🐙🍦🥟🧗‍♀️🗿🏬🩸🧯🈺💜🇨🇻🇨🇨🤝🤪😣😈🎃🤖☠️💩👻👅🦷😶‍🌫️🦋🐛🦉🦀🌈☃️🍉🥑"

struct EmojiArtDocumentView: View {
    
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize: CGFloat = 40
    
    
    var body: some View {
        
        VStack(spacing: 0){
            documentBody
            palette
        }
    }
    
    // will toggle with a long press
    
    @State private var showDeleteButtomforEmoji = false
    
        
        var documentBody: some View {
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        OptionalImage(uiImage: document.backgroundImage)
                            .scaleEffect(selectedEmojis.isEmpty ? zoomScale : steadyStateZoomScale )
                            .position(convertFromEmojiCoordinates((0, 0), in: geometry))
                    )
                    .gesture(doubleTapToZoom (in: geometry.size))
                    
                    
                    if document.backgroundImageFetchStatus == .fetching {
                        ProgressView().scaleEffect(4)
                    } else {
                        ForEach(document.emojis) { emoji in
                            Text(emoji.text)
                                .font(.system(size: fontSize(for: emoji)))
                                .selectionEffect(for: emoji, in: selectedEmojis, ShowDelete: showDeleteButtomforEmoji) {
                                   
                                    deleteSelectedEmoji(emoji)
                                    
                                }
                                .scaleEffect(getZoomScaleForEmoji(emoji))
                                .position(position(for: emoji, in: geometry))
                                .gesture(selectionGesture(on: emoji).simultaneously(with: selectedEmojis.contains(emoji) ? panEmojiGesture(on: emoji): nil ).simultaneously(with: selectedEmojis.contains(emoji) ? longPressGestureToDelete(on: emoji) : nil))
                                
                            
                            
                            
                        }
                    }
                }
//                .dropDestination  (for: String.self){ emojis, location in
//
//
//                    return drop(emoji: emojis, location: location, in: geometry)
//                }
                
                .clipped()
                .onDrop(of: [.plainText, .url, .image], isTargeted: nil) { providers, location in

                     return drop(providers: providers, location: location, in: geometry)
                }
                // old way to drop new way for iOS 16 and up is above
                
                .gesture(zoomGesture().simultaneously(with: selectedEmojis.isEmpty ? panGesture() : nil ).simultaneously(with: !selectedEmojis.isEmpty ? tapToUnselectEmojis() : nil))
            }
        }
    
    
    
    
    private func drop(providers: [NSItemProvider], location: CGPoint, in geometry: GeometryProxy ) -> Bool {
        
        
        var found = providers.loadObjects(ofType: URL.self) { url in
            
            document.setBackground(.url(url.imageURL))
             
        }
        
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                
                if let data = image.jpegData(compressionQuality: 1.0) {
                    document.setBackground(.imageData(data))
                }
            }
        }
            
            if !found {
                found = providers.loadObjects(ofType: String.self) { string in
                    
                    if let emoji = string.first, emoji.isEmoji {
                        
                        document.addEmoji(
                            String(emoji),
                            at: converToEmojiCoordinates(location, in: geometry) ,
                            size: defaultEmojiFontSize / zoomScale
                        )
                    }
                }
            }
        return found
    }
    
    
        // function below is for the new way to drop in iOS 16 and up
    
//    private func drop(emoji: [String], location: CGPoint, in geometry: GeometryProxy ) -> Bool {
//
//        if !emoji.isEmpty {
//            document.addEmoji(
//                emoji.first!,
//                at: converToEmojiCoordinates(location, in: geometry) ,
//                size: emojisFontSize)
//
//            return true
//        } else {
//            return false
//        }
//    }
    
    
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        
        let xOffset = emoji.x + Int(gestureEmojiPanOffset.width)
        let yOffset = emoji.y + Int(gestureEmojiPanOffset.height)
        
        switch selectedEmojis.contains(emoji) {
            
        case true: return convertFromEmojiCoordinates((xOffset, yOffset), in: geometry)
            
        case false: return convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
        }
        
      }
    
    
    
    
    private func converToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        
        let center = geometry.frame(in: .local).center
        
        let location = CGPoint(
            x: location.x - panOffset.width - center.x / zoomScale,
            y: location.y - panOffset.height - center.y / zoomScale
        )
        
        return (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        
        let center = geometry.frame(in: .local).center // does center is in the utility file it dont excist in CGRect in swiftUI
        
        return CGPoint (
            x: center.x  + CGFloat(location.x) * zoomScale + panOffset.width,
            y: center.y  + CGFloat(location.y) * zoomScale + panOffset.height
        )
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }
    
    // This func will delte the emoji once the trash buttom appears after a long press
    private func deleteSelectedEmoji(_ emoji: EmojiArtModel.Emoji) {
        
        withAnimation{
            if selectedEmojis.contains(emoji) {selectedEmojisId.remove(emoji.id)}
            
            document.deleteEmoji(emoji)
            
        }

            if selectedEmojis.isEmpty {showDeleteButtomforEmoji = false}
        
    }
    
    
    //MARK: - Select Emojis
    
    @State private var selectedEmojisId: Set<Int> = []
    
    
    private var selectedEmojis: Set<EmojiArtModel.Emoji> {
        var selectedEmojis = Set<EmojiArtModel.Emoji>()
        for id in selectedEmojisId {
            selectedEmojis.insert(document.emojis.first(where: {$0.id == id})!)
        }
        return selectedEmojis
    }
    
    private func selectionGesture(on emoji: EmojiArtModel.Emoji) -> some Gesture {
        TapGesture()
            .onEnded {
                withAnimation {
                    selectedEmojisId.toggleMembership(of: emoji.id)
                }
            }
    }
    
    
    //MARK: - Tap to unselect all emijis
    
    private func tapToUnselectEmojis() -> some Gesture {
        TapGesture()
            .onEnded{
                withAnimation (.linear(duration: 0.15)){
                    selectedEmojisId = []
                }
            }
    }
    
    
    
    //MARK: - Long Press gesture to revel delete buttom in selected effect
    
    private func longPressGestureToDelete (on emoji: EmojiArtModel.Emoji) -> some Gesture {
        LongPressGesture(minimumDuration: 1.0)
            .onEnded { endOfLongPress in
                withAnimation{
                    endOfLongPress ? showDeleteButtomforEmoji.toggle() : nil
                }
            }
    }
    
    
    //MARK: - dragGesture Code
    
    @State private var steadyStatePanOffSet: CGSize = .zero
    @GestureState private var gesturePanOffset: CGSize = .zero
    @GestureState private var gestureEmojiPanOffset: CGSize = .zero
    
    
    
    
    private var panOffset: CGSize {
        // there is a extention to cgsize that allow basic math opperation for CGSize
        (steadyStatePanOffSet + gesturePanOffset) * zoomScale
    }
    
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                gesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
        
            .onEnded { finalDragGestureValue in
                steadyStatePanOffSet = steadyStatePanOffSet + (finalDragGestureValue.translation / zoomScale)
            }
    }
    
    
    private func panEmojiGesture(on emoji: EmojiArtModel.Emoji) -> some Gesture {
        DragGesture()
            .updating($gestureEmojiPanOffset) { latestDragGesture, gestureEmojiPanOffset, _ in
                
                
                    gestureEmojiPanOffset = latestDragGesture.translation / zoomScale
                
            }
        
            .onEnded { finalDragGestureValue in
                
                
                    for emoji in selectedEmojis {
                        document.moveEmoji(emoji, by: finalDragGestureValue.distance / zoomScale)
                    }
                
            }
    }
    

    //MARK: - zoom Gestures code
    
    //State var that control scaling gesture
    
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    private func getZoomScaleForEmoji(_ emoji: EmojiArtModel.Emoji) -> CGFloat {
         selectedEmojis.isEmpty ? zoomScale : selectedEmojis.contains(emoji) ? zoomScale : steadyStateZoomScale
     }
     
     private func zoomGesture() -> some Gesture {
         MagnificationGesture()
             .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                 gestureZoomScale = latestGestureScale
                
             }
             .onEnded { gestureScaleAtEnd in
                 if selectedEmojis.isEmpty {
                     steadyStateZoomScale *= gestureScaleAtEnd
                    
                 } else {
                     
                     for emoji in selectedEmojis {
                         document.scaleemoji(emoji, by: gestureScaleAtEnd)
                     }
                 }
             }
     }
    
    
    //MARK: - doubleTapZoom
    
  
    
    private func doubleTapToZoom (in size: CGSize) -> some Gesture {
        // Discrete Gesture
        TapGesture(count: 2)
            .onEnded {
                withAnimation{
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit (_ image: UIImage?, in size: CGSize) {
        
        if let image = image, image.size.width > 0, image.size.height > 0, size.width > 0, size.height > 0 {
            
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            
            // code below will make it to jump to the middel
            steadyStatePanOffSet = .zero
            
            steadyStateZoomScale = min(hZoom, vZoom)
            
        }
        
    }
    
    
        var palette: some View {
            ScrollingEmojisView(emojis: testEmojis)
                .font(.system(size: defaultEmojiFontSize))
        }
        
}

    
    



//MARK: - Priview code
  

struct EmojiArtDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
            .previewInterfaceOrientation(.landscapeRight)
    }
}
