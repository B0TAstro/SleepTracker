import Foundation

@MainActor
class StatsViewModel: ObservableObject {
    @Published var sleepStore: SleepStore
    
    // Data for charts
    var weeklyData: [SleepSession] {
        // Return sessions for the last 7 days sorted by date
        let cutoff = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        return sleepStore.sessions
            .filter { $0.bedTime > cutoff }
            .sorted { $0.bedTime < $1.bedTime }
    }
    
    var averageSleepDuration: String {
        let sessions = weeklyData
        guard !sessions.isEmpty else { return "0h" }
        
        let totalHours = sessions.reduce(0) { $0 + $1.durationHours }
        let avg = totalHours / Double(sessions.count)
        
        let hours = Int(avg)
        let minutes = Int((avg - Double(hours)) * 60)
        return "\(hours)h \(minutes)m"
    }
    
    init(sleepStore: SleepStore) {
        self.sleepStore = sleepStore
    }
}
