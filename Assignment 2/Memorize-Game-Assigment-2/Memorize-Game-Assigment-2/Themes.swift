//
//  Themes.swift
//  Memorize-Assigment-1
//
//  Created by Kevin Martinez on 12/23/22.
//

import SwiftUI

struct Themes {
    
    private(set) var title: String
    private(set) var themeColor: Color
    private(set) var emojis: [String]
    
    
    private static let vehicles = Themes(title: "Vehicles",
                                         themeColor: .red,
                                         emojis: ["✈️", "🚀", "🚂","🚁",
                                                  "🚗","🚕","🚙","🚌",
                                                  "🚎","🏎","🚓","🚑",
                                                  "🚒","🚐","🛻","🚚",
                                                  "🚛","🚜","🚍","🚘",
                                                  "🚖","🚡","🚠","🚟"])
    
    
    private static let plans = Themes(title: "Plans",
                                      themeColor: .green,
                                      emojis: [ "🌴", "🪵", "🌱", "🌿",
                                                "🌳", "🌲", "🎄", "🌵",
                                                "🎋", "🪴", "🎍", "🍀",
                                                "💐", "🌾", "🌺", "🌻",
                                                "🌼", "🌸"])
    
    private static let flags = Themes(title: "Flags",
                                      themeColor: .purple,
                                      emojis: ["🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸",
                                               "🇧🇭", "🇧🇸", "🇦🇿", "🇦🇹",
                                               "🇦🇺", "🇦🇼", "🇦🇲", "🇦🇷",
                                               "🇦🇬" , "🇦🇶", "🇦🇮", "🇦🇴",
                                               "🇦🇩", "🇧🇩", "🇧🇧", "🇧🇪",
                                               "🇧🇿", "🇧🇯", "🇧🇲", "🇧🇹",
                                               "🇧🇴", "🇧🇦", "🇧🇷", "🇻🇬",
                                               "🇹🇩", "🇨🇫", "🇰🇾", "🇨🇻",
                                               "🇮🇨", "🇨🇦", "🇨🇲", "🇰🇭",
                                               "🇧🇮", "🇧🇫", "🇧🇬", "🇧🇳",
                                               "🇮🇴", "🇨🇱", "🇨🇳", "🇨🇽",
                                               "🇨🇨", "🇨🇴", "🇰🇲"])
    
    private static let sports = Themes(title: "Sports",
                                       themeColor: .teal,
                                       emojis: ["⛷️", "🏂", "🪂", "🏋️",
                                                "🤼‍♀️", "🤸‍♀️", "⛹️‍♀️", "🤺",
                                                "🤾‍♂️", "🏌️", "🏇", "🧘🏽‍♀️",
                                                "🏄", "🚣‍♀️", "🧗‍♀️", "🚴"])
    private static let weather = Themes(title: "Weather",
                                        themeColor: .brown,
                                        emojis: ["🌡️", "☁️", "☀️", "🌤️",
                                                 "🌦️", "🌧️", "⛈️", "🌩️",
                                                 "⚡️", "❄️", "🌪️", "💨",
                                                 "🌈", "☃️"])
    private static let faces = Themes(title: "Faces",
                                      themeColor: .yellow,
                                      emojis: ["😀", "🥹", "😂", "🥲",
                                               "😇", "🥳", "🥸", "🥰",
                                               "😍", "🤓", "🤯", "🥶",
                                               "😶‍🌫️", "🫥", "🤠", "😈",
                                               "😵‍💫", "🤐", "🫣", "😡"])
    
    static let themes = [vehicles, plans, flags, sports, weather, faces]
}
