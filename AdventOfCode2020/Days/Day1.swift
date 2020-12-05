import Foundation

struct Day1: Day {
    static func run(input: String) {
        let numbers = splitInput(input).compactMap(Int.init)
        part1(numbers: numbers)
        part2(numbers: numbers)
    }

    private static func part1(numbers: [Int]) {
        let magicNumber = 2020
        for x in numbers {
            for y in numbers {
                if x + y == magicNumber {
                    let result = x * y
                    printResult(dayPart: 1, message: "\(x) * \(y) = \(result)")
                    return
                }
            }
        }
    }

    private static func part2(numbers: [Int]) {
        let magicNumber = 2020
        for x in numbers {
            for y in numbers {
                for z in numbers {
                    if x + y + z == magicNumber {
                        let result = x * y * z
                        printResult(dayPart: 2, message: "\(x) * \(y) * \(z) = \(result)")
                        return
                    }
                }
            }
        }
    }
}
