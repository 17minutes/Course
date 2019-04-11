import UIKit

class ViewController: UIViewController {
    
    private func spawnNewGame() -> Concentration {
        self.theme = spawnNewTheme()
        self.emojiArray = self.theme.emojiSet
        
        return Concentration(numberOfPairsCard: self.numberOfPairsCard)
    }
    
    private lazy var game = spawnNewGame()
    
    var numberOfPairsCard: Int {
        return (self.cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var emojiArray: [Emoji] = []
    private var emoji: [Card: Emoji] = [:]
    private var theme: Theme = spawnNewTheme()
    
    @IBOutlet private var restartButton: UIButton!
    
    @IBOutlet private var scoreLabel: UILabel!
    
    @IBAction private func emojiButtonAction(_ sender: UIButton) {
        
        if let index = self.cardButtons.firstIndex(of: sender) {
            self.game.chooseCard(at: index)
            self.updateViewModel()
        } else {
            print("Unhandled Error!!!")
        }
        
    }
    
    @IBAction private func restartButtonAction(_ sender: UIButton) {
        self.game = self.spawnNewGame()
        self.updateViewModel()
    }
    
    private func updateViewModel() {
        self.view.backgroundColor = theme.backColor
        self.scoreLabel.backgroundColor = UIColor(white: 0, alpha: 0)
        self.scoreLabel.textColor = theme.cardBackColor
        self.restartButton.backgroundColor = theme.cardBackColor
        self.restartButton.setTitleColor(theme.backColor, for: .normal)
        
        for index in self.cardButtons.indices {
            let button = self.cardButtons[index]
            let card = self.game.board[index]
            
            if card.isFaceUp {
                button.setTitle(self.emoji(for: card), for: .normal)
                button.backgroundColor = self.theme.cardForeColor
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.6910475492, blue: 0, alpha: 0) : self.theme.cardBackColor
            }
            
            self.scoreLabel.text = "Счет: \(self.game.getScore()) (переворотов: \(self.game.getFlips()))"
        }
        
        if isTerminalState(state: game.state) {
            let alert = UIAlertController(
                title: "Игра окончена",
                message: "Итоговый счет: \(self.game.getScore())",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "Новая игра",
                style: .default,
                handler: {
                    action in switch action.style {
                    default:
                        self.game = self.spawnNewGame()
                        self.updateViewModel()
                    }
                }
            ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func emoji(for card: Card) -> String {
        if self.emoji[card] == nil, self.emojiArray.count > 0 {
            self.emoji[card] = self.emojiArray.remove(at: self.emojiArray.count.arc4random)
        }
        
        return self.emoji[card] ?? "?"
    }
    
    override func viewDidLoad() {
        self.game = self.spawnNewGame()
        self.updateViewModel()
    }
}
