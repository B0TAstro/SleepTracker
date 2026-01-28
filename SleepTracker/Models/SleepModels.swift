import Foundation

enum DeviceType: String, Codable, CaseIterable {
    case iphone = "iPhone"
    case mac = "Mac"
    case watch = "Watch"
    case vision = "Vision Pro"
}

struct SleepSchedule: Codable, Equatable {
    var targetBedtime: Date
    var targetWakeUpTime: Date
    var sleepGoalHours: Double
    
    static var `default`: SleepSchedule {
        let calendar = Calendar.current
        var components = DateComponents()
        components.hour = 23 // 11 PM
        components.minute = 0
        let bedtime = calendar.date(from: components) ?? Date()
        
        components.hour = 7 // 7 AM
        let wakeUp = calendar.date(from: components) ?? Date()
        
        return SleepSchedule(targetBedtime: bedtime, targetWakeUpTime: wakeUp, sleepGoalHours: 8.0)
    }
}

struct SleepSession: Codable, Identifiable {
    var id: UUID = UUID()
    var bedTime: Date
    var wakeTime: Date
    var qualityScore: Int // 0-100
    
    var duration: TimeInterval {
        return wakeTime.timeIntervalSince(bedTime)
    }
    
    var durationHours: Double {
        return duration / 3600.0
    }
}
