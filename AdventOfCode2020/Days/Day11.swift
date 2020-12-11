import Foundation

struct Day11: Day {
    static func run(input: String) {
        let floorMap = splitInput(input).map { $0.map(Int.floorTile(from:)) }
        part1(floorMap: floorMap)
    }

    private static func part1(floorMap: FloorMap) {
        let height = floorMap.count
        let width = floorMap.first!.count

        var floorMap = floorMap
        var hasDoneChanges = false

        repeat {
            var changes = floorMap
            hasDoneChanges = false
            (0..<height).forEach({ y in
                (0..<width).forEach({ x in
                    if shouldChange(seat: (y: y, x: x), floorMap: floorMap, height: height, width: width) {
                        changes[y][x] = -floorMap[y][x]
                        hasDoneChanges = true
                    }
                })
            })

            floorMap = changes
        } while hasDoneChanges

        let takenSeats = floorMap.map { row in
            row.filter { $0 == 1 }.reduce(0, +)
        }.reduce(0, +)

        printResult(dayPart: 1, message: "Number of taken seats after iterating: \(takenSeats)")
    }

    private static func shouldChange(seat: Seat, floorMap: FloorMap, height: Int, width: Int) -> Bool {
        let seatValue = floorMap[seat.y][seat.x]

        if seatValue == 0 { return false }
        var adjacentSeatsTaken = 0

        var y = seat.y - 1
        repeat {
            defer { y += 1 }
            if y < 0 || y >= height { continue }

            var x = seat.x - 1
            repeat {
                defer { x += 1 }
                if x < 0 || x >= width || (x == seat.x && y == seat.y) { continue }
                if floorMap[y][x] == 1 {
                    adjacentSeatsTaken += 1
                }
            } while x <= seat.x + 1
        } while y <= seat.y + 1

        if seatValue == 1 {
            return adjacentSeatsTaken >= 4
        }
        return adjacentSeatsTaken == 0
    }
}

// MARK: - Types

private typealias FloorMap = [[Int]]
private typealias Seat = (y: Int, x: Int)

extension Int {
    static func floorTile(from value: Character) -> Int {
        switch value {
        case ".": return 0
        case "L": return -1
        case "#": return 1
        default: fatalError("Could not parse value: '\(value)'")
        }
    }
}
