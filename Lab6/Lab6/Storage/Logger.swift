import Foundation

class Logger {
    func info(text: String) {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(format.string(from: Date()) + ": " + text)
    }
}
