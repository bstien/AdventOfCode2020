import Foundation

struct Seat {
    let row: Int
    let column: Int
    var seatId: Int { row * 8 + column }
}

struct Day5: Day {
    static func run(input: String) {
        let lines = splitInput(input)
        part1(lines: lines)
        part2(lines: lines)
    }

    static func part1(lines: [String]) {
        let highestId = lines.map(parseSeat).map(\.seatId).max()
        printResult(dayPart: 1, message: "Highest seat ID: \(highestId!)")
    }

    static func part2(lines: [String]) {
        let takenSeats = lines.map(parseSeat).map(\.seatId).sorted()

        guard
            let minId = takenSeats.first,
            let maxId = takenSeats.last,
            let mySeat = (minId...maxId).filter({ !takenSeats.contains($0) }).first
        else {
            printResult(result: .fail, dayPart: 2, message: "Could not find my seath ☹️")
            return
        }

        printResult(dayPart: 2, message: "My seat ID: \(mySeat)")
    }
}

// MARK: - Parsing

extension Day5 {
    static func parseSeat(from line: String) -> Seat {
        var rowHigh = 127
        var rowLow = 0
        var colHigh = 7
        var colLow = 0

        for char in Array(line) {
            switch char {
            case "F":
                rowHigh = rowHigh - (rowHigh - rowLow) / 2 - 1
            case "B":
                rowLow = rowLow + (rowHigh - rowLow) / 2 + 1
            case "L":
                colHigh = colHigh - (colHigh - colLow) / 2 - 1
            case "R":
                colLow = colLow + (colHigh - colLow) / 2 + 1
            default: break
            }
        }

        return Seat(row: rowLow, column: colLow)
    }
}
