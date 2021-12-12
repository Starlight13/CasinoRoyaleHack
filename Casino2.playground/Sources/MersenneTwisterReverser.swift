import Foundation

public class MersenneTwisterReverser {
    let w: Int64 = 32
    let n: Int64 = 624
    let m: Int64 = 397
    let r: Int64 = 31
    
    let a = "9908B0DF";
    
    let u: Int64 = 11;
    let d = "FFFFFFFF";
    let s: Int64 = 7;
    let b = "9D2C5680";
    let t: Int64 = 15;
    let c = "EFC60000";
    
    let l: Int64 = 18;
    let f = 1812433253;
    
    let lowerMask = "7FFFFFFF";
    let upperMask = "80000000";
    
    var array: [Int64];
    
    public init () {
        array = [Int64]()
    }
    
    public func appendToArray(element: Int64) {
        let value = reverse(value: element)
        array.append(value)
    }
    
    public func getArray() -> [Int64] {
        return array
    }
    
    func reverse(value: Int64) -> Int64 {
        var  x = value;
        
        x = rightReverse(x, l, ((Int64(1) << w) - 1));
        x = leftReverse(x, t, Int64(c, radix: 16)!);
        x = leftReverse(x, s, Int64(b, radix: 16)!);
        x = rightReverse(x, u, Int64(d, radix: 16)!);

        return x;
    }
    
    func rightReverse (_ y: Int64, _ a: Int64, _ b: Int64) -> Int64 {
        var x: Int64 = 0
        for i in 0..<w {
            if (i < a) {
                x = x | getBit(y, i);
            } else {
                x = x | (getBit(y, i) ^ ((getBit(x, i - a) >> a) & getBit(b, i)));
            }
        }
        return x;
    }
    
    func leftReverse (_ y:Int64, _ a:Int64, _ b:Int64) -> Int64 {
        return reverseBits(rightReverse(reverseBits(y), a, reverseBits(b)));
    }
    
    func reverseBits(_ x: Int64) -> Int64{
        var reversed:Int64 = 0;
        var xVal = x
        for _ in 0..<w {
            reversed = reversed << 1;
            if (xVal > 0) {
                if ((xVal & 1) == 1) {
                    reversed = reversed ^ 1;
                }
                xVal = xVal >> 1;
            }
        }
        return reversed;
    }
    
    func getBit (_ a: Int64, _ i: Int64) -> Int64 {
        return a & (1 << (w - i - Int64(1)))
    }
}

