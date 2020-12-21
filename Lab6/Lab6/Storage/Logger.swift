import Foundation

class Logger {
    func info(text: String) {
        let format = DateFormatter()
        print(format.string(from: Date()) + ": " + text)
    }
}
