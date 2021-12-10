//
//  File.swift
//
//
//  Created by dsadas asdasd on 20.11.2021.
//
import Foundation

func discardMultiply(_ a: UInt32, _ b: UInt32) -> UInt32 {
    let ah = UInt64(a & 0xFFFF0000) >> 16
    let al = UInt64(a & 0x0000FFFF)
    let bh = UInt64(b & 0xFFFF0000) >> 16
    let bl = UInt64(b & 0x0000FFFF)

    // Most significant bits overflow anyways, so don't bother
    // let F  = ah * bh
    let OI = ah * bl + al * bh
    let L  = al * bl

    let result = (((OI << 16) & 0xFFFFFFFF) + L) & 0xFFFFFFFF
    return UInt32(result)
}

public class MersenneTwister: IteratorProtocol {
    private let w: UInt32 = 32
    private let n: Int = 624
    private let m: Int = 397
    private let r: UInt32 = 31
    private let a: UInt32 = 0x9908B0DF
    private let (u, d): (UInt32, UInt32) = (11, 0xFFFFFFFF)
    private let (s, b): (UInt32, UInt32) = ( 7, 0x9D2C5680)
    private let (t, c): (UInt32, UInt32) = (15, 0xEFC60000)
    private let l: UInt32 = 18
    private let f: UInt32 = 1812433253

    private var state: [UInt32]
    private var index = 0

    init(seed: UInt32 = 5489) {
        var x = [seed]
        for i in 1..<n {
            let prev = x[i-1]
            let c = discardMultiply(f, prev ^ (prev >> (w-2)))
            let (next, _) = c.addingReportingOverflow(UInt32(i))
            x.append(next)
        }
        self.state = x
    }

    private func twist() {
        for i in 0..<n {
            let x = (state[i] & 0xFFFF0000) + ((state[(i+1) % n] % UInt32(n)) & 0x0000FFFF)
            var xA = x >> 1
            if (x % 2 != 0) {
                xA = xA ^ a
            }
            state[i] = state[(i + m) % n] ^ xA
            index = 0
        }
    }

    public func next() -> UInt32? {
            if self.index > n { fatalError("Generator never seeded") }
            if self.index == n { self.twist() }

            var result = state[index]
            result = result ^ ((result >> u) & d)
            result = result ^ ((result << s) & b)
            result = result ^ ((result << t) & c)
            result = result ^ (result >> l)

            index += 1
            return result
        }
}

//let mt = MersenneTwister(seed: 10)
//
//for _ in 0..<10 {
//    print(mt.next())
//}
