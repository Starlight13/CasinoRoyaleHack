import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

//createAccount (id: "13125"){ result in
//    switch result {
//    case .success(let account):
//        print(account)
//    default:
//        print("Something Went Wrong")
//    }
//}

//play (mode: Mode.Mt, id: "13125", bet: "1", number: "13") { result in
//    switch result {
//    case .success(let betResult):
//        print(betResult)
//    case .failure(let json):
//        print(json)
//    default:
//        print("Something Went Wrong")
//    }
//
//}


//let mt = MersenneTwister(seed: 81)
//

var arr = [Int64]()
arr.append(35465212)
arr.append(12345675)
arr.append(76346573)

let mt = MersenneTwisterGenerator(array: arr)
//
for _ in 0..<50 {
    print(mt.next())
}


//Int64(120) >> Int64(2)
//
//Int64(786) ^ 0

//let lcg = LCG()

//lcg.helloWorld()
