import Foundation

struct Day6: Day {
    static func run(input: String) {
        let groupAnswers = readAnswers(from: input)
        part1(answers: groupAnswers)
        part2(answers: groupAnswers)
    }

    private static func part1(answers: [[String]]) {
        let uniqueCharacters = answers.map { $0.flatMap(Array.init) }.map(Set.init)
        let numberOfAnswers = uniqueCharacters.reduce(0, { $0 + $1.count })
        printResult(dayPart: 1, message: "Sum of answer count: \(numberOfAnswers)")
    }

    private static func part2(answers: [[String]]) {
        let questionsAllAnsweredYesTo = answers.reduce(0, { result, groupAnswers in
            guard let firstPerson = groupAnswers.first else { return result }

            var numberOfYes = 0
            for answer in Array(firstPerson) {
                if groupAnswers.allSatisfy({ $0.contains(answer) }) {
                    numberOfYes += 1
                }
            }

            return result + numberOfYes
        })

        printResult(dayPart: 2, message: "Number of questions everyone in the group answered yes to: \(questionsAllAnsweredYesTo)")
    }

    private static func readAnswers(from input: String) -> [[String]] {
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

        return answers
    }
}
