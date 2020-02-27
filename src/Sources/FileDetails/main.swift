import Foundation
import Files
import CSV

guard let folder = try? CommandLine.arguments[safe: 1].flatMap(Folder.init(path:)) else {
    print("ERROR: Please specify a path to a valid folder.")
    exit(1)
}

let csv = try! CSVWriter(stream: .toMemory())

try! csv.write(row: [
    "Name",
    "Path",
    "Creation date",
    "Last modification date",
])

for file in folder.files.recursive.includingHidden {
    try! csv.write(row: [
        file.name,
        file.path,
        file.creationDate.map(formatDate),
        file.modificationDate.map(formatDate),
    ].compactMap { $0 })
}

csv.stream.close()

let csvData = csv.stream.property(forKey: .dataWrittenToMemoryStreamKey) as! Data
let outputFileName = "filedetails-\(folder.name).csv"

let desktopFolder = try! Folder.home.subfolder(at: "Desktop")

do {
    let outputFile = try desktopFolder.createFile(named: outputFileName)
    try outputFile.write(csvData)
} catch {
    print("ERROR: Could not create output file at \(desktopFolder.path)\(outputFileName). Make sure the file doesn't already exist.")
    exit(1)
}

print("Saved file details to \(desktopFolder.path)\(outputFileName)")
