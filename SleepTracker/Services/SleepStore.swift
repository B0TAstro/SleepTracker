import Foundation

@MainActor
class SleepStore: ObservableObject {
    @Published var schedule: SleepSchedule
    @Published var sessions: [SleepSession] = []
    
    private let fileManager = FileManager.default
    
    var sleepDurationLastNight: String {
        guard let lastSession = sessions.sorted(by: { $0.bedTime < $1.bedTime }).last else {
            return "No Data"
        }
        let hours = Int(lastSession.durationHours)
        let minutes = Int((lastSession.durationHours - Double(hours)) * 60)
        return "\(hours)h \(minutes)m"
    }
    
    var lastNightQualityMessage: String {
        guard let lastSession = sessions.sorted(by: { $0.bedTime < $1.bedTime }).last else {
            return "Start tracking your sleep!"
        }
        
        if lastSession.durationHours >= schedule.sleepGoalHours - 0.5 {
            return "Great job! You met your goal."
        } else if lastSession.durationHours >= schedule.sleepGoalHours - 2 {
            return "Not quite there, try to sleep earlier."
        } else {
            return "You need more rest."
        }
    }
    
    init() {
        self.schedule = SleepSchedule.default
        load()
    }
    
    // MARK: - Persistence
    
    private var documentsDirectory: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var scheduleFile: URL {
        documentsDirectory.appendingPathComponent("sleep_schedule.json")
    }
    
    private var sessionsFile: URL {
        documentsDirectory.appendingPathComponent("sleep_sessions.json")
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let scheduleData = try encoder.encode(schedule)
            try scheduleData.write(to: scheduleFile)
            
            let sessionsData = try encoder.encode(sessions)
            try sessionsData.write(to: sessionsFile)
            
            print("Data saved successfully.")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    func load() {
        let decoder = JSONDecoder()
        
        if let data = try? Data(contentsOf: scheduleFile),
           let loadedSchedule = try? decoder.decode(SleepSchedule.self, from: data) {
            self.schedule = loadedSchedule
        }
        
        if let data = try? Data(contentsOf: sessionsFile),
           let loadedSessions = try? decoder.decode([SleepSession].self, from: data) {
            self.sessions = loadedSessions
        } else {
            // Generate some mock data if empty for demo purposes
            generateMockData()
        }
    }
    
    private func generateMockData() {
        let calendar = Calendar.current
        let today = Date()
        var newSessions: [SleepSession] = []
        
        for i in 1...7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                // Random sleep duration between 5 and 9 hours
                let sleepHours = Double.random(in: 5...9)
                let bedTime = calendar.date(bySettingHour: 23, minute: Int.random(in: 0...59), second: 0, of: date)!
                let wakeTime = calendar.date(byAdding: .minute, value: Int(sleepHours * 60), to: bedTime)!
                let score = Int((sleepHours / 8.0) * 100)
                
                newSessions.append(SleepSession(bedTime: bedTime, wakeTime: wakeTime, qualityScore: min(score, 100)))
            }
        }
        self.sessions = newSessions
    }
    
    func addSession(bedTime: Date, wakeTime: Date) {
        let session = SleepSession(bedTime: bedTime, wakeTime: wakeTime, qualityScore: 85) // Simplified score
        sessions.append(session)
        save()
    }
}
