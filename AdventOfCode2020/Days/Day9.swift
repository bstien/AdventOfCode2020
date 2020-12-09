import Foundation

struct Day9: Day {
    private static let preambleLength = 25

    static func run(input: String) {
        let numbers = splitInput(input).compactMap(Int.init)

        if let invalidNumber = part1(numbers: numbers) {
            part2(numbers: numbers, invalidNumber: invalidNumber)
        }
    }

    private static func part1(numbers: [Int]) -> Int? {
        var invalidNumbers = [Int]()
        var index = 0
        repeat {
            let preamble = Array(numbers[index..<(index + preambleLength)])
            let number = numbers[index + preambleLength]

            let isInvalidNumber = !preamble.map { pre -> Bool in
                let diff = number - pre
                return diff != pre && preamble.contains(where: { $0 == diff})
            }.contains(true)

            if isInvalidNumber {
                invalidNumbers.append(number)
            }

            index += 1
        } while numbers.count > index + preambleLength

        guard let firstInvalidNumber = invalidNumbers.first else {
            printResult(result: .fail, dayPart: 1, message: "Could not find an invalid number")
            return nil
        }

        printResult(dayPart: 1, message: "First invalid number: \(firstInvalidNumber)")
        return firstInvalidNumber
    }

    private static func part2(numbers: [Int], invalidNumber: Int) {
    }
}
