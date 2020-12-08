import Foundation

struct Day8: Day {
    static func run(input: String) {
        let instructions = parseInstructions(from: input)
        part1(instructions: instructions)
    }

    private static func part1(instructions: [Instruction]) {
        var visitedInstructions = Set<Int>()
        var programCounter = 0
        var accumulator = 0

        repeat {
            visitedInstructions.insert(programCounter)
            let instruction = instructions[programCounter]

            switch instruction.operation {
            case .acc:
                accumulator += instruction.value
                programCounter += 1
            case .jmp:
                programCounter += instruction.value
            case .nop:
                programCounter += 1
            }
        } while !visitedInstructions.contains(programCounter)

        printResult(dayPart: 1, message: "Value of acc when trying to run an instruction a second time: \(accumulator)")
    }
}

// MARK: - Parsing

extension Day8 {
    private static func parseInstructions(from input: String) -> [Instruction] {
        splitInput(input).reduce(into: [Instruction]()) { result, line in
            let split = line.split(separator: " ").map(String.init)

            guard let intValue = Int(split[1]), let operation = Operation(rawValue: split[0]) else { return }
            result.append(Instruction(operation: operation, value: intValue))
        }
    }
}

// MARK: - Private types

private enum Operation: String {
    case jmp, acc, nop
}

private struct Instruction {
    let operation: Operation
    let value: Int
}
