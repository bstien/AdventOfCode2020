import Foundation

struct Day6: Day {
    static func run(input: String) {
        let groupAnswers = readAnswers(from: input)
        part1(answers: groupAnswers)
    }

    private static func part1(answers: [[Character]]) {
        let numberOfAnswers = answers.map(Set.init).reduce(0, { $0 + $1.count })
        printResult(dayPart: 1, message: "Sum of answer count: \(numberOfAnswers)")
    }

    private static func readAnswers(from input: String) -> [[Character]] {
        var answers = [[String]]()
        var groupsFound = 0

        for line in splitInput(input, omittingEmptySubsequences: false) {
            if line.isEmpty {
                groupsFound += 1
                continue
            }

            if answers.count > groupsFound, !answers[groupsFound].isEmpty {
                answers[groupsFound].append(line)
            } else {
                answers.append([line])
            }
        }

        return answers.map { $0.flatMap(Array.init) }
    }
}
