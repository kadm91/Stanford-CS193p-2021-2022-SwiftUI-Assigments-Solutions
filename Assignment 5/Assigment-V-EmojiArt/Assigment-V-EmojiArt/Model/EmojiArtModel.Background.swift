//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by Kevin Martinez on 7/20/23.
//

import Foundation

extension EmojiArtModel {
    
    enum Background: Equatable {
        
        case blank
        case url(URL) //associated data
        case imageData(Data) //associated data
        
        var url: URL? {
            switch self {
            case .url(let url): return url
            default: return nil
            }
        }
        
        var imageData: Data? {
            switch self {
            case .imageData(let data): return data
            default: return nil
            }
        }
    }
    
}
