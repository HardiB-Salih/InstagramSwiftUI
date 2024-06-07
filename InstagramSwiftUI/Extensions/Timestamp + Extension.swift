//
//  Timestamp + Extension.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import Firebase

extension Timestamp {
    /**
     Converts a timestamp to a human-readable string representing the time elapsed since the timestamp.

     - Returns: A `String` indicating the time elapsed since the timestamp. For example, "5m ago" for 5 minutes ago, "3h ago" for 3 hours ago, etc. If the time difference is less than a second, it returns "Just now".

     # Usage Example #
     ```swift
     let timestamp = Timestamp() // Assume Timestamp is initialized with some date
     let elapsedTimeString = timestamp.timestampString()
     print(elapsedTimeString) // Output could be "5m ago", "3h ago", "1d ago", etc.
     ```
     
     
     # Implementation Details #
     - **DateComponentsFormatter**: The method uses `DateComponentsFormatter` to format the time difference between the current date and the timestamp.
     - **Allowed Units**: The formatter considers seconds, minutes, hours, days, and weeks.
     - **Maximum Unit Count**: It limits the output to the largest single unit (e.g., if the difference is in hours and minutes, only hours will be shown).
     - **Units Style**: The output style is abbreviated (e.g., "m" for minutes, "h" for hours).
     - **Time Difference Calculation**: The time difference is calculated using `timeIntervalSince`
     **/
    func timestampString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let timeDiff = Date().timeIntervalSince(self.dateValue())
        if timeDiff < 1 { return "Just now" }
        let string = formatter.string(from: self.dateValue(), to: Date()) ?? ""
        return "\(string) ago"
    }
}

extension Timestamp: Comparable {
    public static func < (lhs: Timestamp, rhs: Timestamp) -> Bool {
        return lhs.seconds < rhs.seconds || (lhs.seconds == rhs.seconds && lhs.nanoseconds < rhs.nanoseconds)
    }
    
    public static func == (lhs: Timestamp, rhs: Timestamp) -> Bool {
        return lhs.seconds == rhs.seconds && lhs.nanoseconds == rhs.nanoseconds
    }
}

