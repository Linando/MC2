//
//  File.swift
//  MC2
//
//  Created by Linando Saputra on 11/07/19.
//  Copyright © 2019 Linando Saputra. All rights reserved.
//

import Foundation

struct Stock: Decodable {
    let metaData: MetaData
    var timeSeries: TimeSeries
    
    private enum CodingKeys: String, CodingKey{
        case metaData = "Meta Data"
        case timeSeries = "Time Series (Daily)"
    }
}

struct MetaData: Decodable {
    let symbol: String
    
    private enum CodingKeys: String, CodingKey{
        case symbol = "2. Symbol"
    }
}

struct TimeSeries {
    struct StockDate {
        let date: String
        let open: String
        let high: String
        let low: String
        let close: String
        let volume: String
    }
    var stockDates: [StockDate]
    
    init(stockDates: [StockDate] = []) {
        self.stockDates = stockDates
    }
}

extension TimeSeries: Encodable {
    struct StockDateKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
        
        static let open = StockDateKey(stringValue: "1. open")!
        static let high = StockDateKey(stringValue: "2. high")!
        static let low = StockDateKey(stringValue: "3. low")!
        static let close = StockDateKey(stringValue: "4. close")!
        static let volume = StockDateKey(stringValue: "5. volume")!
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StockDateKey.self)
        
        for stockDate in stockDates {
            
            let dateKey = StockDateKey(stringValue: stockDate.date)!
            var dateContainer = container.nestedContainer(keyedBy: StockDateKey.self, forKey: dateKey)
            
            try dateContainer.encode(stockDate.open, forKey: .open)
            try dateContainer.encode(stockDate.high, forKey: .high)
            try dateContainer.encode(stockDate.low, forKey: .low)
            try dateContainer.encode(stockDate.close, forKey: .close)
            try dateContainer.encode(stockDate.volume, forKey: .volume)
        }
    }
}

extension TimeSeries: Decodable {
    public init(from decoder: Decoder) throws {
        var stockDates = [StockDate]()
        let container = try decoder.container(keyedBy: StockDateKey.self)
        for key in container.allKeys {
            // Note how the `key` in the loop above is used immediately to access a nested container.
            let dateContainer = try container.nestedContainer(keyedBy: StockDateKey.self, forKey: key)
            let open = try dateContainer.decode(String.self, forKey: .open)
            let high = try dateContainer.decode(String.self, forKey: .high)
            let low = try dateContainer.decode(String.self, forKey: .low)
            let close = try dateContainer.decode(String.self, forKey: .close)
            let volume = try dateContainer.decode(String.self, forKey: .volume)
            
            // The key is used again here and completes the collapse of the nesting that existed in the JSON representation.
            let stockDate = StockDate(date: key.stringValue, open: open, high: high, low: low, close: close, volume: volume)
            stockDates.append(stockDate)
        }
        
        self.init(stockDates: stockDates)
    }
}
