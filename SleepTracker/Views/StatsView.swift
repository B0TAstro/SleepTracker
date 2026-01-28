import SwiftUI
import Charts

struct StatsView: View {
    @ObservedObject var viewModel: StatsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Sleep Analysis")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .padding(.top, 40)
            
            // Average Card
            HStack {
                VStack(alignment: .leading) {
                    Text("Weekly Average")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(viewModel.averageSleepDuration)
                        .font(.system(size: 34, weight: .bold, design: .monospaced))
                        .foregroundColor(.green)
                }
                Spacer()
                Image(systemName: "chart.xyaxis.line")
                    .font(.largeTitle)
                    .foregroundColor(.green.opacity(0.5))
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(20)
            
            // Chart
            VStack(alignment: .leading) {
                Text("Last 7 Days")
                    .font(.headline)
                    .padding(.bottom, 20)
                
                if viewModel.weeklyData.isEmpty {
                    Text("No data available yet.")
                        .foregroundColor(.gray)
                        .frame(height: 200)
                } else {
                    Chart {
                        ForEach(viewModel.weeklyData) { session in
                            BarMark(
                                x: .value("Day", session.bedTime, unit: .day),
                                y: .value("Hours", session.durationHours)
                            )
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                            .cornerRadius(5)
                        }
                        
                        RuleMark(y: .value("Goal", viewModel.sleepStore.schedule.sleepGoalHours))
                            .foregroundStyle(.orange)
                            .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                            .annotation(position: .topLeading) {
                                Text("Goal")
                                    .font(.caption)
                                    .foregroundColor(.orange)
                            }
                    }
                    .frame(height: 300)
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .day)) { value in
                            AxisValueLabel(format: .dateTime.weekday(.abbreviated))
                        }
                    }
                }
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(20)
            
            Spacer()
        }
        .padding()
    }
}
