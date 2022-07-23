//
//  CalendarView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 18/07/2022.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.colorScheme) var colorScheme
    private let calendar: Calendar
    private let monthFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private let fullFormatter: DateFormatter
    
    @State private var selectedDate = Self.now
    private static var now = Date()
    
    @FetchRequest(sortDescriptors: []) var climbs: FetchedResults<Climb>
    
    init(calendar: Calendar) {
        self.calendar = calendar
        self.monthFormatter = DateFormatter(dateFormat: "MMMM YYYY", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
        self.fullFormatter = DateFormatter(dateFormat: "dd MMMM yyyy", calendar: calendar)
    }
    
    var body: some View {
        VStack {
            CalendarViewComponent(
                calendar: calendar,
                date: $selectedDate,
                content: { date in
                    ZStack {
                        Button(action: { selectedDate = date }) {
                            Text(dayFormatter.string(from: date))
                                .padding(6)
                                // Added to make selection sizes equal on all numbers.
                                .frame(width: 33, height: 33)
                                .foregroundColor(calendar.isDateInToday(date) || calendar.isDate(date, inSameDayAs: selectedDate) ? Color.white : date.timeIntervalSinceNow.sign == .plus ? .secondary : .primary)
                                .background(
                                    calendar.isDateInToday(date) ? Color.red : calendar.isDate(date, inSameDayAs: selectedDate) ? .blue : .clear
                                )
                                .cornerRadius(7)
                                .shadow(color: colorScheme == .dark ? .white.opacity(0.4) : .black.opacity(0.35), radius: 5)
                        }
                        .disabled(date.timeIntervalSinceNow.sign == .plus)

                        
                        if dateHasClimbs(date: date) {
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.red)
                                .offset(x: CGFloat(24),
                                        y: CGFloat(33))
                            
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.blue)
                                .offset(x: CGFloat(17),
                                        y: CGFloat(33))
                            
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.green)
                                .offset(x: CGFloat(31),
                                        y: CGFloat(33))
                        }
                    }
                },
                trailing: { date in
                    Text(dayFormatter.string(from: date))
                        .foregroundColor(.secondary)
                },
                header: { date in
                    Text(weekDayFormatter.string(from: date)).fontWeight(.bold)
                },
                title: { date in
                    HStack {
                        
                        Button {
                            guard let newDate = calendar.date(
                                byAdding: .month,
                                value: -1,
                                to: selectedDate
                            ) else {
                                return
                            }
                            
                            selectedDate = newDate
                            
                        } label: {
                            Label(
                                title: { Text("Previous") },
                                icon: {
                                    Image(systemName: "chevron.left")
                                        .font(.title2)
                                    
                                }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        Button {
                            selectedDate = Date.now
                        } label: {
                            Text(monthFormatter.string(from: date))
                                .foregroundColor(.blue)
                                .font(.title2)
                                .padding(2)
                        }
                        
                        Spacer()
                        
                        Button {
                            guard let newDate = calendar.date(
                                byAdding: .month,
                                value: 1,
                                to: selectedDate
                            ) else {
                                return
                            }
                            
                            selectedDate = newDate
                            
                        } label: {
                            Label(
                                title: { Text("Next") },
                                icon: {
                                    Image(systemName: "chevron.right")
                                        .font(.title2)
                                    
                                }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                        }
                    }
                }
            )
            .equatable()
            
        }
    }
    
    func dateHasClimbs(date: Date) -> Bool {
        for climb in climbs {
            if calendar.isDate(date, inSameDayAs: climb.date ?? Date()) {
                return true
            }
        }
        
        return false
    }
    
    func numberOfClimbsInDate(date: Date) -> Int {
        var count: Int = 0
        for climb in climbs {
            if calendar.isDate(date, inSameDayAs: climb.date ?? Date()) {
                count += 1
            }
        }
        return count
    }
}

// MARK: - Component

public struct CalendarViewComponent<Day: View, Header: View, Title: View, Trailing: View>: View {
    @Environment(\.managedObjectContext) var moc
    // Injected dependencies
    private var calendar: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let trailing: (Date) -> Trailing
    private let header: (Date) -> Header
    private let title: (Date) -> Title
    private let fullFormatter: DateFormatter
    
    // Constants
    private let daysInWeek = 7
    
    @FetchRequest var climbs: FetchedResults<Climb>
    @State private var numberOfResults = 0
    
    public init(
        calendar: Calendar,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder trailing: @escaping (Date) -> Trailing,
        @ViewBuilder header: @escaping (Date) -> Header,
        @ViewBuilder title: @escaping (Date) -> Title
    ) {
        self.calendar = calendar
        self._date = date
        self.content = content
        self.trailing = trailing
        self.header = header
        self.title = title
        self.fullFormatter = DateFormatter(dateFormat: "dd MMMM yyyy", calendar: calendar)
        
        _climbs = FetchRequest<Climb>(sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)],
                                     predicate: NSPredicate(
                                        format: "date >= %@ && date <= %@",
                                        Calendar.current.startOfDay(for: date.wrappedValue) as CVarArg,
                                        Calendar.current.startOfDay(for: date.wrappedValue + 86400) as CVarArg))
    }
    
    public var body: some View {
        let month = date.startOfMonth(using: calendar)
        let days = makeDays()
        
        VStack {
            
            Section(header: title(month)) { }
            
            VStack {
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                    ForEach(days.prefix(daysInWeek), id: \.self, content: header)
                }
                
                Divider()
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                    ForEach(days, id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                            content(date)
                        } else {
                            trailing(date)
                        }
                    }
                }
            }
            .frame(height: days.count == 42 ? 300 : 270)
            
            if climbs.count > 0 {
                List {
                    NavigationLink {
                        Text(fullFormatter.string(from: date))
                            .font(.title)
                        List {
                            ForEach(climbs) { climb in
                                NavigationLink(destination: ClimbView(climb: climb)) {
                                    ClimbRowView(climb: climb)
                                }
                            }
                        }
                    } label: {
                        Text("See climbs for: \(fullFormatter.string(from: date))")
                            .font(.title2)
                    }

                    ForEach(climbs) { climb in
                        NavigationLink(destination: ClimbView(climb: climb)) {
                            ClimbRowView(climb: climb)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let climb = climbs[index]
            moc.delete(climb)
        }

        do {
            if moc.hasChanges {
              try moc.save()
            }
        } catch {
            print("Failed to remove climb from row.")
        }
    }
}

// MARK: - Conformances

extension CalendarViewComponent: Equatable {
    public static func == (lhs: CalendarViewComponent<Day, Header, Title, Trailing>, rhs: CalendarViewComponent<Day, Header, Title, Trailing>) -> Bool {
        lhs.calendar == rhs.calendar && lhs.date == rhs.date
    }
}

// MARK: - Helpers

private extension CalendarViewComponent {
    func makeDays() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else {
            return []
        }

        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        return calendar.generateDays(for: dateInterval)
    }
}

private extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]

        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date = date else { return }

            guard date < dateInterval.end else {
                stop = true
                return
            }

            dates.append(date)
        }

        return dates
    }

    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(
            for: dateInterval,
            matching: dateComponents([.hour, .minute, .second], from: dateInterval.start)
        )
    }
}

private extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}

private extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}
