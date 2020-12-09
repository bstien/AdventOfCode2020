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
        let list = contiguousNumbers(from: numbers, addingTo: invalidNumber)

        guard let min = list.min(), let max = list.max() else {
            printResult(result: .fail, dayPart: 2, message: "Could not get smallest/highest number from \(list)")
            return
        }

        printResult(dayPart: 2, message: "Encryption weakness = \(min + max)")
    }
}

private extension Day9 {
    static func contiguousNumbers(from numbers: [Int], addingTo value: Int) -> [Int] {
        var start = 0
        var end = 1
        var hasFoundList = false
        repeat {
            let sum = Array(numbers[start...end]).reduce(0, +)

            if sum == value {
                hasFoundList = true
            } else if sum < value {
                end += 1
            } else {
                start += 1
                end = start + 1
            }
        } while !hasFoundList

        return Array(numbers[start...end])
    }
}
