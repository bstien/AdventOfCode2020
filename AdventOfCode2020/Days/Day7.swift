import Foundation

private typealias BagRules = [String: [(name: String, qty: Int)]]

struct Day7: Day {
    static func run(input: String) {
        let bagRules = parseBags(from: input)
        part1(rules: bagRules)
        part2(rules: bagRules)
    }

    private static func part1(rules: BagRules) {
        var checkedBags = [String: Bool]()

        func containsShinyGoldBag(name: String) -> Bool {
            if let existingResult = checkedBags[name] { return existingResult }
            var foundShinyGold = false

            if let subBags = rules[name] {
                if !subBags.filter({ $0.name.hasPrefix("shiny gold") }).isEmpty {
                    foundShinyGold = true
                } else {
                    foundShinyGold = subBags.map(\.name).contains(where: containsShinyGoldBag)
                }
            }

            checkedBags[name] = foundShinyGold
            return foundShinyGold
        }

        let result = rules.map(\.key).filter(containsShinyGoldBag)
        printResult(dayPart: 1, message: "Number of bags that can contain shiny gold: \(result.count)")
    }

    private static func part2(rules: BagRules) {
        var checkedBags = [String: Int]()

        func findNumberOfChildren(for bagName: String) -> Int {
            if let existingResult = checkedBags[bagName] { return existingResult }

            var bagCount = 1
            if let children = rules[bagName], !children.isEmpty {
                bagCount = children.map { $0.qty * findNumberOfChildren(for: $0.name) }.reduce(1, +)
            }

            checkedBags[bagName] = bagCount
            return bagCount
        }


        let bagCount = findNumberOfChildren(for: "shiny gold") - 1
        printResult(dayPart: 2, message: "Number of bags contained in shiny gold: \(bagCount)")
    }
}

// MARK: - Parsing

extension Day7 {
    private static func parseBags(from input: String) -> BagRules {
        var rules = BagRules()
        let lines = splitInput(input)

        for line in lines {
            let components = line.components(separatedBy: "bags contain").map { $0.trimmingCharacters(in: .whitespaces) }

            guard let bagName = components.first, let bagsContained = components.last else { continue }

            if bagsContained.hasPrefix("no") {
                rules[bagName] = []
                continue
            }

            rules[bagName] = bagsContained
                .components(separatedBy: ", ")
                .compactMap { bag -> (name: String, qty: Int)? in
                    let split = bag.split(separator: " ")
                    guard let qtyString = split.first, let qty = Int(qtyString) else { return nil }

                    let name = split[1...2].joined(separator: " ")
                    return (name: name, qty: qty)
                }
        }

        return rules
    }
}
