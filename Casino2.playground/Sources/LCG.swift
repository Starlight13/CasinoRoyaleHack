import Foundation


extension NSDecimalNumber {
    func modInverse (modulus: NSDecimalNumber) -> NSDecimalNumber {
        return self.raising(toPower: -1).raising(toPower: modulus.intValue)
    }
    
    func mod (modulus: NSDecimalNumber) {
        
    }
}

public class LcgConstants {

    var a: Int64;
    var m: Int64;
    var c: Int64;
    
    init() {
        a = 0
        m = 0
        c = 0
    }
    
    public func evalConstants (numbers: [Int64]) {
        m = Int64(pow(2, 32.0))
        
        let a1 = NSDecimalNumber(value: numbers[1]).subtracting(NSDecimalNumber(value: numbers[2]))
        
        let a2 = NSDecimalNumber(value: numbers[0]).subtracting(NSDecimalNumber(value: numbers[1]))
        
        self.a = a1.multiplying(by: a2.modInverse(modulus: NSDecimalNumber(value: m))).int64Value
    }
}
