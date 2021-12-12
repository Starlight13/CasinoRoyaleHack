import Foundation

public class MersenneTwisterGenerator {
    let w = 32
    let n = 624
    let m = 397
    let r = 31
    
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

    public var array: [Int64];
    var index: Int;

    let seed: Int64?;
    
    public init (array: [Int64]) {
        index = 0;
        self.array = array;
        seed = nil;
        twist();
    }
    
    public init (seed: Int64) {
        self.seed = seed
        
        index = n + 1
        array = [Int64]()
        array.append(seed);
        for i in 1..<n {
            let bitshift = (array[i-1] >> (w-2))
            let xor = array[i-1] ^ bitshift
            let component = Int64(f) * xor + Int64(i)
            
            array.append(component & Int64("ffffffff", radix: 16)!)
        }
        
    }
    
    public func next() -> Int64 {
        if (index >= n) {
            twist()
            index = 0
        }
        
        var result = array[index];
        result = result ^ ((result >> u) & Int64(d, radix: 16)!);
        result = result ^ ((result << s) & Int64(b, radix: 16)!);
        result = result ^ ((result << t) & Int64(c, radix: 16)!);
        result = result ^ (result >> l);

        index += 1
        return result
    }

    func twist() {
        for i in 0..<n {
            let x = (array[i] & Int64(upperMask, radix: 16)!) + (array[(i + 1) % n] & Int64(lowerMask, radix: 16)!)
            var xA = x >> 1
            if ( (x % 2) != 0) {
                xA = xA ^ Int64(a, radix: 16)!
            }
            array[i] = array[(i + m) % n] ^ xA
        }
    }
}
