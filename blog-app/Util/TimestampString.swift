//
//  TimestampString.swift
//  blog-app
//
//  Created by dykoon on 2021/11/04.
//

import Firebase

struct TimestampString {
  static func dateString(_ timestamp: Timestamp) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth] // 시간 단위 설정
    formatter.maximumUnitCount = 1 // 시간 단위를 몇개를 나타낼 것인가
    formatter.unitsStyle = .abbreviated // 단위의 가장 앞글자 약어(s, m, h, d, w 등)으로 설정
        
    // 한글로 변환
    var calender = Calendar.current
    calender.locale = Locale(identifier: "ko")
    formatter.calendar = calender
        
    // 만들어진 시간부터 지금(Date())까지 얼마만큼의 시간이 걸렸는지 계산해서 차이(difference)를 반환
    return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
}
