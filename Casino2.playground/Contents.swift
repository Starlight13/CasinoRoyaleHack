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


let mt = MersenneTwisterGenerator(seed: 756)
//
for _ in 0..<50 {
    print(mt.next())
}

