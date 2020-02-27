import Foundation

func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .long
    dateFormatter.timeZone = .current
    
    return dateFormatter.string(from: date)
}
