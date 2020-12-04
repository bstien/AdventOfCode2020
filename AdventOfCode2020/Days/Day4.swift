import Foundation

struct Day4: Day {
    static func run(input: String) {
        let lines = splitInput(input, omittingEmptySubsequences: false)
        let credentials = readCredentials(from: lines)

        part1(credentials: credentials)
    }

    static func part1(credentials: [[String]]) {
        let requiredFields = [
            "byr",
            "iyr",
            "eyr",
            "hgt",
            "hcl",
            "ecl",
            "pid"
        ]

        let validPassportCount = credentials.filter { credential in
            let fieldsPresent = credential.compactMap { $0.split(separator: ":").map(String.init).first }
            return requiredFields.allSatisfy { field in fieldsPresent.contains(field) }
        }.count

        printResult(dayPart: 1, message: "Number of valid passports: \(validPassportCount)")
    }

    static func readCredentials(from lines: [String]) -> [[String]] {
        var credentials = [Int: [String]]()
        var emptyLinesFound = 0

        for line in lines {
            if line.isEmpty {
                emptyLinesFound += 1
                continue
            }

            credentials[emptyLinesFound, default: []].append(line)
        }

        return credentials.flatMap { _, lines -> [String] in
            lines.joined(separator: " ").split(separator: " ").map(String.init)
        }
    }
}
