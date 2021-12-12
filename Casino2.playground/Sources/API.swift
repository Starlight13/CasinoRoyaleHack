import Foundation


public struct Account: Codable {
    public var id: String?
    public var money: Int?
    public var deletionTime: String?
}

public struct BetResult: Codable {
    public var message: String?
    public var account: Account?
    public var realNumber: Int64?
}

public enum Mode {
    case Lcg
    case Mt
    case BetterMt
}

func createAccount (id: String, completionHandler: @escaping(Result<Account,Error>) -> Void) {
    
    let endpoint = "http://95.217.177.249/casino/createacc"
    
    var components = URLComponents(string: endpoint)!
    components.queryItems = [URLQueryItem(name: "id", value: id)]
    
    let dataTask = URLSession.shared.dataTask(with: components.url!) { (data, _, error) in
        guard error == nil else {
            completionHandler(.failure(error!))
            return
        }

        guard let jsonData = data else {
            return
        }
        
        do {
            let account = try JSONDecoder().decode(Account.self, from: jsonData)
            completionHandler(.success(account))


        } catch {
            print("Something Went wrong")
            completionHandler(.failure(error))
        }
    }

    dataTask.resume()
}

func play(mode: Mode, id: String, bet: String, number: String, completionHandler: @escaping(Result<BetResult,Error>) -> Void) {

    let endpoint = "http://95.217.177.249/casino/play\(mode)"
    
    var components = URLComponents(string: endpoint)!
    components.queryItems = [URLQueryItem(name: "id", value: id), URLQueryItem(name: "bet", value: bet), URLQueryItem(name: "number", value: number)]
    
    print(components.url!)
    let dataTask = URLSession.shared.dataTask(with: components.url!) { (data, _, error) in
        guard error == nil else {
            completionHandler(.failure(error!))
            return
        }

        guard let jsonData = data else {
            return
        }
        
        do {
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
            print(json)
            let betResult = try JSONDecoder().decode(BetResult.self, from: jsonData)
            completionHandler(.success(betResult))


        } catch {
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
            print("Something Went wrong")
            completionHandler(.failure(json as! Error))
        }
    }

    dataTask.resume()
}

public func createAccSync(id: String) -> (Account?, Error?) {
    let semaphore = DispatchSemaphore(value: 0)
    var account: Account?
    var resultError: Error?
    createAccount (id: id) { result in
        switch result {
        case .success(let result):
            account = result
        case .failure(let error):
            resultError = error
        }
        semaphore.signal()
    }
    
    semaphore.wait()
    return (account, resultError)
}

public func playSync(mode: Mode, id: String, bet: String, number: String) -> (BetResult?, Error?) {
    let semaphore = DispatchSemaphore(value: 0)
    var betResult: BetResult?
    var resultError: Error?
    play (mode: mode, id: id, bet: bet, number: number) { result in
        switch result {
        case .success(let result):
            betResult = result
        case .failure(let error):
            resultError = error
        }
        semaphore.signal()
    }
    
    semaphore.wait()
    return (betResult, resultError)
}

public func getAccountId() -> String{
    var id = 13123
    
    while true {
        let account = createAccSync(id: "\(id)").0
        if account?.id != nil {
            print("Using id \(id)")
            return "\(id)"
        }
        print("Id \(id) is already in use")
        id += 1
    }
}
