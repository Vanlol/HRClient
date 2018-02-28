//
//  Date+Category.swift
//  Doctor
//
//  Created by Hengzhan on 2017/12/12.
//  Copyright © 2017年 Hengzhan. All rights reserved.
//

import Foundation

extension Date {
    //MARK: 加载上一个月数据
    func previousMonthDate() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year,.month,.day], from: self)
        components.day = 15
        if components.month == 1 {
            components.month = 12
            components.year! -= 1
        } else {
            components.month! -= 1
        }
        let previousDate = calendar.date(from: components)
        return previousDate!
    }
    //MARK: 加载下一个月数据
    func nextMonthDate() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year,.month,.day], from: self)
        components.day = 15
        if components.month == 12 {
            components.month = 1
            components.year! += 1
        } else {
            components.month! += 1
        }
        let nextDate = calendar.date(from: components)
        return nextDate!
    }
    //MARK: 当前月的总天数
    func totalDaysInMonth() -> Int {
        let totalDays = (Calendar.current.range(of: .day, in: .month, for: self)?.count)!
        
        return totalDays
    }
    //MARK: 当前月的一号是周几
    func firstWeekDayInMonth() -> Int {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year,.month,.day], from: self)
        components.day = 1
        let firstDay = calendar.date(from: components)
        // 默认一周第一天序号为 1 ，而日历中约定为 0 ，故需要减一
        let firstWeekday = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: firstDay!)! - 1
        return firstWeekday
    }
    //MARK: 当前 Date 对应的日
    func dateDay() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day!
    }
    //MARK: 当前 Date 对应的月
    func dateMonth() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        return components.month!
    }
    //MARK: 当前 Date 对应的年
    func dateYear() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year!
    }
    //MARK: 获取今天事件字符串
    func getCurrentDateStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    //MARK: 获取当前日期的后七天或前七天
    func getWeekDate(isBefore:Bool) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.day = isBefore ? -6 : 6
        let minDate = calendar.date(byAdding: comps, to: self)
        return minDate!
    }
    //MARK: 获取当前日期的前一个月或后一个月
    func getMonthDate(isBefore:Bool) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.month = isBefore ? -1 : 1
        let minDate = calendar.date(byAdding: comps, to: self)
        return minDate!
    }
    
    
    
    
    
    //MARK: 获取某段时间间隔内的所有天数 (默认起始时间为2017-05-01)
    func getDayCount() -> Int {
        var days = 0
        let fromStr = "2017-05-01"
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        let fromDate = formater.date(from: fromStr)!
        let time = self.timeIntervalSince(fromDate)
        days = Int(time)/(3600*24)
        return days
    }
    //MARK: 获取某段时间间隔内的月数 (默认起始时间为2017-05-01)
    func getMonthCount() -> Int {
        var days = 0
        let fromStr = "2017-05-01"
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        let fromDate = formater.date(from: fromStr)!
        let time = self.timeIntervalSince(fromDate)
        days = Int(time)/(3600*24*4)
        return days
    }
    //MARK: 获取所有周(默认起始时间为2017-05-01)
    func getWeeks() -> [String] {
        var dateStr = [String]()
        let formater = DateFormatter()
        formater.dateFormat = "MM月dd日"
        let nowTime = timeIntervalSince1970
        var beginTime = nowTime - Double(3600*24*getDayCount())
        
        while beginTime<=nowTime {
            let date = Date(timeIntervalSince1970: beginTime)
            beginTime += 3600*24
            dateStr.append(formater.string(from: date))
        }
        
        return dateStr
    }
    //获取一段时间间隔的所有天数
    func getAllDays() -> [String] {
        var dateStr = [String]()
        let count = getDayCount()
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        let str = "2017-05-01"
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        var aaa = formater.date(from: str)!
        for _ in 0..<count {
            comps.day = 1
            let berforeDate = calendar.date(byAdding: comps, to: aaa)
            aaa = berforeDate!
            //formater.dateFormat = "MM月dd"
            dateStr.append(formater.string(from: aaa))
        }
        return dateStr
    }
    //获取一段时间间隔的所有天数
    func getAllMonths() -> [String] {
        var dateStr = [String]()
        dateStr.append("2017-05-01")
        let count = getMonthCount()
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        let str = "2017-05-01"
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        var aaa = formater.date(from: str)!
        
        for _ in 0..<count {
            comps.day = 4
            let berforeDate = calendar.date(byAdding: comps, to: aaa)
            aaa = berforeDate!
            //formater.dateFormat = "MM月dd"
            dateStr.append(formater.string(from: aaa))
        }
        
        return dateStr
    }
    
    
    
/* -------------------------------------------------------------------------------------------------------------------- */
    /** 返回当前时间(时区为当前时区) **/
    func currentZoneDate() -> Date {
        //let curDate = Date()
        //let time = TimeZone.current.secondsFromGMT(for: curDate)
        //let zoneDate = curDate.addingTimeInterval(TimeInterval(time))
        let time = TimeZone.current.secondsFromGMT()                        //当前时区与格陵兰时区相差的秒数
        let zoneDate = Date().addingTimeInterval(TimeInterval(time))
        return zoneDate
    }
    
    /** 将时间转换为yyyy-MM-dd格式 **/
    func formatterDate() -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt.string(from: self)
    }
    /** 比较self和from之间的时间差值 **/
    func deltaFrom(date:Date) -> DateComponents {
        let cmps = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date, to: self)
        return cmps
    }
    
    /** 获取当前日期的,年,月,日,时,分,秒 **/
    func compontentDetail(detail:Calendar.Component) -> Int {
        let result = Calendar.current.component(detail, from: self)
        return result
    }
    
    /** 是否为今年 **/
    func isYear() -> Bool {
        let nowYear = Calendar.current.component(.year, from: Date().currentZoneDate())
        let selfYear = Calendar.current.component(.year, from: self)
        return nowYear == selfYear
    }
    
    /** 是否为今天 **/
    func isToday() -> Bool {
        let nowCmps = Calendar.current.dateComponents([.year,.month,.day], from: Date().currentZoneDate())
        let selfCmps = Calendar.current.dateComponents([.year,.month,.day], from: self)
        return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day
    }
    
    /** 是否为昨天 **/
    func isYesterday() -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let nowDate = fmt.date(from: fmt.string(from: Date().currentZoneDate()))!
        let selfDate = fmt.date(from: fmt.string(from: self))!
        let cmps = Calendar.current.dateComponents([.year,.month,.day], from: selfDate, to: nowDate)
        return cmps.year == 0 && cmps.month == 0 && cmps.day == 1
    }
    
}








//let date = Date()
//let timeZone = TimeZone(identifier: "CST")
//let formatter = DateFormatter()
//formatter.timeZone = timeZone
//formatter.locale = Locale.current
//formatter.dateFormat = "yyyy-MM"
//let newDate = formatter.string(from: date)

