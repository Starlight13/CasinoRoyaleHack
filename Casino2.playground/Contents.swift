import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true


func winLCG() {
    let userId = getAccountId()
    var money = 0;

    var realNumbers = [Int64]()

    for _ in 0..<3 {
        let result = playSync(mode: Mode.Lcg, id: userId, bet: "1", number: "13")
        realNumbers.append((result.0?.realNumber)!)
        money = (result.0!.account?.money)!
    }

    print(money)

    let lcg = LCG(numbers: realNumbers)

    while true {
        let result = playSync(mode: Mode.Lcg, id: userId, bet: String(money), number: String(Int32(truncatingIfNeeded: lcg.next())))
        money = (result.0!.account?.money)!
        if money >= 1000000 {
            print("You won! 🎉🎉🎉")
            break
        }
    }
}

func winMT() {
    let userId = getAccountId()
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

func winMTBetter() {
    let userId = getAccountId()
    var money = 0;
    
    let sizeToAnalize = 624;
    
    let mtReverser = MersenneTwisterReverser()
    
    for _ in 0..<sizeToAnalize {
        let result = playSync(mode: Mode.BetterMt, id: userId, bet: "1", number: "13")
        mtReverser.appendToArray(element: result.0!.realNumber!)
        money = (result.0!.account?.money)!
    }
    
    print(money)
    let mt = MersenneTwisterGenerator(array: mtReverser.getArray())

    while true {
        let result = playSync(mode: Mode.BetterMt, id: userId, bet: String(money), number: String(mt.next()))
        money = (result.0!.account?.money)!
        if money >= 1000000 {
            print("You won! 🎉🎉🎉")
            break
        }
    }
}


winLCG()
//winMT()
//winMTBetter()


