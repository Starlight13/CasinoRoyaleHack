import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

func winMT(userId: String) {
    var seed: Int64 =  Int64(NSDate().timeIntervalSince1970)
    var realNumbers = [Int64]()
    var money = 0;
    
    for _ in 0..<20 {
        let result = playSync(mode: Mode.Mt, id: userId, bet: "1", number: "13")
        realNumbers.append(result.0!.realNumber!)
        money = (result.0!.account?.money)!
    }
    
    print("Money: \(money)")
    var mt: MersenneTwisterGenerator?
    
infinite: while true {
    mt = MersenneTwisterGenerator(seed: seed)
    for (index, realNumber) in realNumbers.enumerated() {
        if mt?.next() == realNumber {
            if (index == realNumbers.count-1) {
                print("Seed is: \(seed)")
                break infinite
            }
        } else {
            break
        }
    }
    seed -= 1
}
    
    print("Money: \(money)")
    while true {
        let result = playSync (mode: Mode.Mt, id: userId, bet: String(money), number: String(mt!.next())).0
        guard result != nil else {
            return
        }
        
        money = (result?.account?.money)!
        if (money >= 1000000) {
            print("You won! 🎉🎉🎉")
            break
        }
    }
    
}

let userId = getAccountId()
winMT(userId: userId)

