//
//  City.swift
//  PrayerTimeApp
//
//  Created by Maan Abdullah on 03/09/2022.
//

import Foundation

struct City{
    let cityName: String
    let cityNameInEnglish: String
    let cityURL: String
}

let cities = [City(cityName: "الرياض", cityNameInEnglish: "Riyadh", cityURL: "https://api.aladhan.com/v1/hijriCalendarByCity?city=Riyadh&country=SaudiArabia&method=4&month=02&year=1444"), City(cityName: "جدة", cityNameInEnglish: "Jeddah", cityURL: "https://api.aladhan.com/v1/hijriCalendarByCity?city=Jeddah&country=SaudiArabia&method=4&month=02&year=1444"), City(cityName: "مكة", cityNameInEnglish: "Mecca", cityURL: "https://api.aladhan.com/v1/hijriCalendarByCity?city=Mecca&country=SaudiArabia&method=4&month=02&year=1444"), City(cityName: "أبها", cityNameInEnglish: "Abha", cityURL: "https://api.aladhan.com/v1/hijriCalendarByCity?city=Abha&country=SaudiArabia&method=4&month=02&year=1444"), City(cityName: "حائل", cityNameInEnglish: "Hail", cityURL: "https://api.aladhan.com/v1/hijriCalendarByCity?city=Hail&country=SaudiArabia&method=4&month=02&year=1444"), City(cityName: "بريدة", cityNameInEnglish: "Buraydah", cityURL: "https://api.aladhan.com/v1/hijriCalendarByCity?city=Buraydah&country=SaudiArabia&method=4&month=02&year=1444"), City(cityName: "الدمام", cityNameInEnglish: "Dammam", cityURL: "https://api.aladhan.com/v1/hijriCalendarByCity?city=Dammam&country=SaudiArabia&method=4&month=02&year=1444")]
