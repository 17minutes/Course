import Foundation

struct Card: Hashable {
    var hashValue : Int {
        return self.identifier;
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    let isFaceUp: Bool
    let isMatched: Bool
    let isSeen: Bool
    
    let identifier: Int
    

    init(id: Int, faceUp: Bool = false, matched: Bool = false, seen: Bool = false) {
        self.identifier = id
        self.isFaceUp = faceUp
        self.isMatched = matched
        self.isSeen = seen
    }
    
    func clone() -> Card {
        assert(!self.isSeen, "You cannot clone a card that has already been opened")
        return Card(id: self.identifier, faceUp: self.isFaceUp, matched: self.isMatched)
    }
}

struct CardFactory {
    static var pendingId = 0
    
    private static func nextId() -> Int {
        let prevId = CardFactory.pendingId
        CardFactory.pendingId += 1
        return prevId
    }
    
    static func produce(
        id: Int? = nil,
        faceUp: Bool = false,
        matched: Bool = false,
        seen: Bool = false
    ) -> Card {
        return Card(
            id: id ?? CardFactory.nextId(),
            faceUp: faceUp,
            matched: matched,
            seen: seen
        )
    }
    
    init() { }
}
