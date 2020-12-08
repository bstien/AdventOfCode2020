import Foundation

private enum Instruction {
    case jmp(Int)
    case acc(Int)
    case nop

    init?(name: String, value: Int) {
        switch name {
        case "jmp": self = .jmp(value)
        case "acc": self = .acc(value)
        case "nop": self = .nop
        default: return nil
        }
    }
}

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

            switch instruction {
            case .acc(let value):
                accumulator += value
                programCounter += 1
            case .jmp(let value):
                programCounter += value
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

            guard let intValue = Int(split[1]), let instruction = Instruction(name: split[0], value: intValue) else { return }
            result.append(instruction)
        }
    }
}
