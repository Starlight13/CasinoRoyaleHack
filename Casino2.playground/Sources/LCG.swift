import Foundation
import BigInt

public class LCG {

    var a: Int64;
    var m: Int64;
    var c: Int64;
    
    var lastNumber: Int64;
    
    public init(numbers: [Int64]) {
        a = 0;
        c = 0;
        m = Int64(pow(2, 32.0))
        lastNumber = numbers[numbers.count - 1]
        evalConstants(numbers: numbers)
    }
    
    func evalConstants (numbers: [Int64]) {
        
        let a1 = BigInt(numbers[1]) - BigInt(numbers[2])
        let a2 = BigInt(numbers[0]) - BigInt(numbers[1])
        
        a = Int64((a1 * (a2.inverse(BigInt(m))!)) % BigInt(m));
        
        c = (numbers[1] - a * numbers[0]) % m
        
        print("a: \(a), m: \(m), c: \(c)")
    }
    
    public func next() -> Int64 {
        lastNumber = (lastNumber * a + c) % m;
        return lastNumber;
    }
}
