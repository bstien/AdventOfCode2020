import Foundation

typealias Passport = [String: String]

struct Day4: Day {
    static func run(input: String) {
        let lines = splitInput(input, omittingEmptySubsequences: false)
        let passports = readPassports(from: lines)

        part1(passports: passports)
    }

    static func part1(passports: [Passport]) {
        let requiredFields = [
            "byr",
            "iyr",
            "eyr",
            "hgt",
            "hcl",
            "ecl",
            "pid"
        ]

        let validPassports = passports.filter { passport in
            requiredFields.allSatisfy { requiredField in
                passport.keys.contains(requiredField)
            }
        }

        printResult(dayPart: 1, message: "Number of valid passports: \(validPassports.count)")
    }

    static func readPassports(from lines: [String]) -> [Passport] {
        var credentials = [Int: [String]]()
        var emptyLinesFound = 0

        for line in lines {
            if line.isEmpty {
                emptyLinesFound += 1
                continue
            }

            credentials[emptyLinesFound, default: []].append(line)
        }

        return credentials.flatMap { _, lines -> Passport in
            lines
                .joined(separator: " ")
                .split(separator: " ")
                .reduce(into: [String: String]()) {
                    let field = $1.split(separator: ":")

                    if let key = field.first, let value = field.last {
                        $0[String(key)] = String(value)
                    }
                }
        }
    }
}
