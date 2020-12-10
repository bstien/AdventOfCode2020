import Foundation

struct Day10: Day {
    static func run(input: String) {
        var adapters = splitInput(input).compactMap(Int.init).sorted()
        adapters = adapters + [adapters.max()! + 3]

        part1(adapters: adapters)
    }

    static func part1(adapters: [Int]) {
        var previousAdapter = 0
        var joltDifference = [Int: Int]()

        for adapter in adapters {
            let diff = adapter - previousAdapter
            joltDifference[diff, default: 0] += 1
            previousAdapter = adapter
        }

        let result = joltDifference[1, default: 0] * joltDifference[3, default: 0]
        printResult(dayPart: 1, message: "Joltdifferences multiplied: \(result)")
    }
}
