

import UIKit

enum DateFormat: String {
    case yearMonthDate = "YYYY-MM-dd"
    case monthDateYear = "MM/dd/yyyy"
    case monthNameYear = "MMMM, yyyy"
    case dateMonthYear = "dd MMM, yyyy"
    case systemDateFormat = "yyyy-MM-dd HH:mm:ss Z"
    case serverFormat = "yyyy-MM-dd HH:mm:ss"
    case delivery    = "yyyy-MM-dd hh:mm a"
    case utcDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case monthDate = "MMM dd"
    case onlyTime = "h:mm a"
    case onlyServerTime = "HH:mm:ss"
    case onlyHours = "HH:mm"
}

class DateUtils: NSObject {
        
    class func formateDate(date:String, fromFormate : String, toFormate:String)-> String {
        
        let df =  DateFormatter()
        df.dateFormat = fromFormate
        let convertedDate = df.date(from: date)
        
        let df1 =  DateFormatter()
        df1.dateFormat = toFormate
        df1.amSymbol = "AM"
        df1.pmSymbol = "PM"
        df1.locale = Locale.current
        df1.timeZone = TimeZone.current

        if let date = convertedDate {
            let convertedDate = df1.string(from: date)
            return convertedDate
        }
        
        return ""
    }
    
    
    class func timeAgoSinceDay(_ date:Date) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.hour, .day, .month, .year]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! > 1) {
            return "\(components.year!) years"
        } else if (components.year! == 1) {
            return "1 year"
        } else if (components.month! > 1) {
            return "\(components.month!) months"
        } else if (components.month! == 1) {
            return "1 month"
        } else {
            if (components.day! == 0) {
                return "Today"
            } else if (components.day! == 1) {
                return "1 day "
            } else {
                return "\(components.day!) days"
            }
        }
    }
    
    class func isDateInThisWeek(_ date: Date) -> Bool {
        let gregorian = Calendar(identifier: .gregorian)
        let todaysComponents: DateComponents? = gregorian.dateComponents([.weekOfYear], from: Date())
        let todaysWeek: Int? = todaysComponents?.weekOfYear
        let otherComponents: DateComponents? = gregorian.dateComponents([.weekOfYear], from: date)
        let datesWeek: Int? = otherComponents?.weekOfYear

        if todaysWeek == datesWeek {
            return true
        }
        return false
    }
    
    class func isDateInThisMonth(_ date: Date) -> Bool {
        let gregorian = Calendar(identifier: .gregorian)
        let todaysComponents: DateComponents? = gregorian.dateComponents([.month], from: Date())
        let todaysWeek: Int? = todaysComponents?.month
        let otherComponents: DateComponents? = gregorian.dateComponents([.month], from: date)
        let datesWeek: Int? = otherComponents?.month
        
        if todaysWeek == datesWeek {
            return true
        }
        return false
    }
    

    
    class func secondsToHoursMinutes (seconds : Int) -> (String) {
        return "Today " + String(format: "%d:%d",seconds / 3600, (seconds % 3600) / 60)
    }
    
    class func getDay(fromDate date : Date?) -> String{
        if let date = date {
            let df = DateFormatter()
            df.dateFormat = "EEEE"
            df.locale = Locale.current
            
            return df.string(from: date)
        }
        return ""
    }
    
    class func getYearMonth(fromDate date : Date = Date()) -> String{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM"
        df.locale = Locale.current
        return df.string(from: date)
    }
    
    class func getMonth(fromDate date : Date?) -> String {
        if let date = date {
            let df = DateFormatter()
            df.dateFormat = "MMMM"
            df.locale = Locale.current
            
            return df.string(from: date)
        }
        return ""
    }
        
    class func getUTCDateFrom(date : Date)-> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let defaultTimeZoneStr = formatter.string(from: date)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: defaultTimeZoneStr)!
    }
    
    class func getDateFromString(stringDate: String, formate : String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formate
        let date = dateFormatter.date(from: stringDate)
        return date
    }
    
    class func getDateFromStringWithoutTimeZone(stringDate: String, formate : String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = formate
        let date = dateFormatter.date(from: stringDate)
        return date
    }
    
    class func getStringFromDate(date: Date, toFormate:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = toFormate
        let now = formatter.string(from: date)
        return now
    }
    
    class func getStringFromDateNew(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = date.dateFormatWithSuffix()
        let now = formatter.string(from: date)
        return now
    }
    

    class func getLocalFrom(UTC date : String)-> String{
        let df =  DateFormatter()
        df.timeZone = TimeZone(identifier: "UTC")
        df.dateFormat = "yyyy-MM-dd HH:mm:ss a"
        let utcDate = df.date(from: date)
        
        let df1 =  DateFormatter()
        df1.dateFormat = "yyyy-MM-dd HH:mm:ss a"
        df1.timeZone = TimeZone.current
        if let utcDate = utcDate{
            let localDate = df1.string(from: utcDate)
            return localDate
        }
        return ""
    }
    
    class func calculateAgeFromStringDate(for stringDate: String, dateFormate: String) -> Int {
        let now = Date()
        let birthday: Date = DateUtils.getDateFromString(stringDate: stringDate, formate: dateFormate) ?? Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let ageInYear = ageComponents.year ?? 0
        return ageInYear
    }
    
    class func setDateLimit(year: Int) -> Date {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.year = year
        return Calendar.current.date(byAdding: dateComponent, to: currentDate)!
    }
    
}

extension Date {
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        return self.set(hour: 23, minute: 59, second: 59)
    }
    
    static let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second, .weekday]
    private var dateComponents: DateComponents {
        return  Calendar.current.dateComponents(Date.components, from: self)
    }

    var year: Int { return dateComponents.year! }
    var month: Int { return dateComponents.month! }
    var day: Int { return dateComponents.day! }
    var hour: Int { return dateComponents.hour! }
    var minute: Int { return dateComponents.minute! }
    var second: Int { return dateComponents.second! }

    var weekday: Int { return dateComponents.weekday! }

    func set(year: Int?=nil, month: Int?=nil, day: Int?=nil, hour: Int?=nil, minute: Int?=nil, second: Int?=nil, tz: String?=nil) -> Date {
        let timeZone = Calendar.current.timeZone
        let year = year ?? self.year
        let month = month ?? self.month
        let day = day ?? self.day
        let hour = hour ?? self.hour
        let minute = minute ?? self.minute
        let second = second ?? self.second
        let dateComponents = DateComponents(timeZone: timeZone, year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        let date = Calendar.current.date(from: dateComponents)
        return date!
    }
    
    func add(component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
}

extension Date {
    
    //Local Time
    static func formattedDate(from dateString: String, currentFormat: DateFormat, to targetFormat: DateFormat = .yearMonthDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = currentFormat.rawValue
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = targetFormat.rawValue
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    //UTC time
    static func formattedDateNew(from dateString: String, currentFormat: DateFormat, to targetFormat: DateFormat = .monthDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = currentFormat.rawValue
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = targetFormat.rawValue
        //dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    func dateFormatWithSuffix() -> String {
        return "MMM d'\(self.daySuffix())'"
    }

    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
    
}
