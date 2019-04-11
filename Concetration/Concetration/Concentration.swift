import Foundation

indirect enum ConcentrationState {
    // No state (e.g., before game start)
    case Nothing
    // (Board, score, flips, previous state)
    case Just([Card], Int, Int, ConcentrationState)
}

func isTerminalState(state: ConcentrationState) -> Bool {
    guard case let .Just(board, _, _, _) = state else {
        assert(false, "Game state cannot be None")
    }
    
    return board.filter{ !$0.isMatched }.isEmpty
}

struct Concentration {
    public var state: ConcentrationState
    
    public var board : [Card] {
        get {
            guard case let .Just(board, _, _, _) = self.state else {
                assert(false, "Game state cannot be None")
            }
            
            return board
        }
    }
    
    private func openCardIndex() -> Int? {
        let openIndices = self.board.indices.filter { self.board[$0].isFaceUp }
        return openIndices.count == 1 ? openIndices[0] : nil;
    }
    
    private mutating func openCard(newValue: Int) {
        let board: [Card] = self.board;
        let isSeen: Bool = board[newValue].isSeen

        let newCards: [Card] = board.indices.map {
            CardFactory.produce(
                id: board[$0].identifier,
                faceUp: $0 == newValue,
                matched: board[$0].isMatched,
                seen: $0 == newValue ? true : board[$0].isSeen
            )
        }
        
        self.updateState(board: newCards, scoreDelta: isSeen ? -1 : 0, prevState: self.state)
        assert(self.openCardIndex() == newValue)
    }
    
    mutating func chooseCard(at index: Int) {
        if !self.board[index].isMatched {
            if let matchIndex = self.openCardIndex(), matchIndex != index {
                let isMatched = self.board[matchIndex] == self.board[index]
                let isSeen = self.board[index].isSeen
                
                let newBoard : [Card] = self.board.enumerated().map {
                    let offset: Int = $0.offset
                    let card: Card = $0.element
                    
                    if offset == index {
                        return CardFactory.produce(
                            id: card.identifier,
                            faceUp: true,
                            matched: isMatched,
                            seen: true
                        )
                    }
                    else if offset == matchIndex {
                        assert(card.isSeen)
                        return CardFactory.produce(
                            id: card.identifier,
                            faceUp: card.isFaceUp,
                            matched: isMatched,
                            seen: true
                        )
                    }
                    else {
                        return card;
                    }
                }
                self.updateState(
                    board: newBoard,
                    scoreDelta: isMatched ? +2 : (isSeen ? -1 : 0),
                    prevState: self.state
                )
            } else {
                self.openCard(newValue: index)
            }
        }
    }
    
    func getScore() -> Int {
        guard case let .Just(_, score, _, _) = state else {
            assert(false, "Game state cannot be None")
        }
        return score
    }
    
    func getFlips() -> Int {
        guard case let .Just(_, _, flips, _) = state else {
            assert(false, "Game state cannot be None")
        }
        return flips
    }
    
    init(numberOfPairsCard: Int) {
        var initBoard = [Card]();
        
        for _ in 0..<numberOfPairsCard {
            let card = CardFactory.produce()
            initBoard += [card, card.clone()]
        }
        
        initBoard.shuffle()
        
        self.state = .Just(initBoard, 0, 0, .Nothing)
    }
    
    private mutating func updateState(board: [Card], scoreDelta: Int, prevState: ConcentrationState) {
        guard case let .Just(_, prevScore, prevFlips, _) = self.state else {
            assert(false, "Game state cannot be None")
        }
        self.state = .Just(board, prevScore + scoreDelta, prevFlips + 1, prevState);
    }
    
}
