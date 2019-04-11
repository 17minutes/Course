import Foundation
import UIKit

typealias Emoji = String
typealias EmojiSet = [Emoji]

struct Theme {
    let emojiSet: EmojiSet
    let cardForeColor: UIColor
    let cardBackColor: UIColor
    let backColor: UIColor
}

func makeEmojiSet(emojiString: String) -> EmojiSet {
    return Array(emojiString).map { "\($0)" }
}

func spawnNewTheme() -> Theme {
    return [
        Theme(
            emojiSet: makeEmojiSet(emojiString: "😀😭😱😛😍😎🤓"),
            cardForeColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            cardBackColor: #colorLiteral(red: 1, green: 0.6910475492, blue: 0, alpha: 1),
            backColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ),
        
        Theme(
            emojiSet: makeEmojiSet(emojiString: "☃️❄️🍧🎿🎅🏾"),
            cardForeColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
            cardBackColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            backColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        ),
        
        Theme(
            emojiSet: makeEmojiSet(emojiString: "🇰🇵🇮🇷🇮🇶🇨🇺🇻🇪🇳🇮"),
            cardForeColor: #colorLiteral(red: 1, green: 0, blue: 0.0603580784, alpha: 1),
            cardBackColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
            backColor: #colorLiteral(red: 0.007843137255, green: 0.3098039216, blue: 0.6352941176, alpha: 1)
        ),
        
        Theme(
            emojiSet: makeEmojiSet(emojiString: "🚧👷🧱🏗️"),
            cardForeColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
            cardBackColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            backColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        ),
        
        Theme(
            emojiSet: makeEmojiSet(emojiString: "👻🎃💀🍬😈"),
            cardForeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            cardBackColor:#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) ,
            backColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ),
    ].choice()
}
