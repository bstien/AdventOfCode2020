import Foundation

struct Day10: Day {
    static func run(input: String) {
        var adapters = splitInput(input).compactMap(Int.init).sorted()
        adapters = adapters + [adapters.max()! + 3]

        part1(adapters: adapters)
        part2(adapters: adapters)
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

    static func part2(adapters: [Int]) {
        func uniqueCombinations(currentAdapter: Int, adapters: [Int]) -> Int {
            if adapters.count == 1 { return 1 }

            let potentialAdapters = adapters.filter { (1...3).contains($0 - currentAdapter) }
            if potentialAdapters.isEmpty { return 0 }

            return potentialAdapters.map { adapter in
                uniqueCombinations(currentAdapter: adapter, adapters: adapters.filter { $0 > adapter })
            }.reduce(0, +)
        }

        let result = uniqueCombinations(currentAdapter: 0, adapters: adapters)
        printResult(dayPart: 2, message: "Number of unique adapter combinations: \(result)")
    }
}
