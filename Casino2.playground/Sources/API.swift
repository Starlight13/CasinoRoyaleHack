import Foundation


public struct Account: Codable {
    var id: String?
    var money: Int?
    var deletionTime: String?
}

public struct BetResult: Codable {
    var message: String?
    var account: Account?
    var realNumber: Int?
}

public enum Mode {
    case Lcg
    case Mt
    case BetterMt
}

public func createAccount (id: String, completionHandler: @escaping(Result<Account,Error>) -> Void) {
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    
    let endpoint = "http://95.217.177.249/casino/createacc"
    
    var components = URLComponents(string: endpoint)!
    components.queryItems = [URLQueryItem(name: "id", value: id)]
    
    
    var request = URLRequest(url: components.url!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let dataTask = session.dataTask(with: request) { (data, _, error) in
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

public func play(mode: Mode, id: String, bet: String, number: String, completionHandler: @escaping(Result<BetResult,Error>) -> Void) {
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    
    let endpoint = "http://95.217.177.249/casino/play\(mode)"
    
    var components = URLComponents(string: endpoint)!
    components.queryItems = [URLQueryItem(name: "id", value: id), URLQueryItem(name: "bet", value: bet), URLQueryItem(name: "number", value: id)]
    
    
    var request = URLRequest(url: components.url!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let dataTask = session.dataTask(with: request) { (data, _, error) in
        guard error == nil else {
            completionHandler(.failure(error!))
            return
        }

        guard let jsonData = data else {
            return
        }
        
        do {
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
