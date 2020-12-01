import Foundation
import QuartzCore

protocol Day {
    static func run(input: String)
}

extension Day {
    static func solve(input: String? = nil) {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.maximumFractionDigits = 3

        guard let input = input ?? readInputFromFile() else {
            print("Could not open input file \(Self.self).txt")
            return
        }

        print("Solving \(Self.self)")

        let start = CACurrentMediaTime()
        run(input: input)
        let end = CACurrentMediaTime()

        let elapsed = end - start
        print("Solved \(Self.self) in \(formatter.string(from: NSNumber(value: elapsed))!)s")

        print("—————————————————————————————————")
    }

    private static func readInputFromFile() -> String? {
        try? Input.get("\(Self.self).txt")
    }

    static func splitInput(_ input: String, separator: Character = "\n") -> [String] {
        input.split(separator: separator).map(String.init)
    }
}
