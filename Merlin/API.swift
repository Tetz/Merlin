// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TokenQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Token($date: [ISO8601DateTime!], $baseAddress: String!, $quoteAddress: String!, $interval: Int) {
      ethereum(network: bsc) {
        __typename
        dexTrades(
          date: {between: $date}
          baseCurrency: {is: $baseAddress}
          quoteCurrency: {is: $quoteAddress}
        ) {
          __typename
          timeInterval {
            __typename
            day(format: "%FT%TZ", count: $interval)
          }
          buyCurrency: baseCurrency {
            __typename
            symbol
            address
          }
          buyAmount: baseAmount
          buyAmountInUsd: baseAmount
          sellCurrency: quoteCurrency {
            __typename
            symbol
            address
          }
          sellAmountInUsd: quoteAmount
          tradeAmount(in: USD)
          volume: quoteAmount
          trades: count
          high: quotePrice(calculate: maximum)
          low: quotePrice(calculate: minimum)
          open: minimum(of: block, get: quote_price)
          close: maximum(of: block, get: quote_price)
          quotePrice
        }
      }
    }
    """

  public let operationName: String = "Token"

  public var date: [String]?
  public var baseAddress: String
  public var quoteAddress: String
  public var interval: Int?

  public init(date: [String]?, baseAddress: String, quoteAddress: String, interval: Int? = nil) {
    self.date = date
    self.baseAddress = baseAddress
    self.quoteAddress = quoteAddress
    self.interval = interval
  }

  public var variables: GraphQLMap? {
    return ["date": date, "baseAddress": baseAddress, "quoteAddress": quoteAddress, "interval": interval]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("ethereum", arguments: ["network": "bsc"], type: .object(Ethereum.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(ethereum: Ethereum? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "ethereum": ethereum.flatMap { (value: Ethereum) -> ResultMap in value.resultMap }])
    }

    /// Ethereum Mainnet / Classic Chain Datasets
    public var ethereum: Ethereum? {
      get {
        return (resultMap["ethereum"] as? ResultMap).flatMap { Ethereum(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "ethereum")
      }
    }

    public struct Ethereum: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Ethereum"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("dexTrades", arguments: ["date": ["between": GraphQLVariable("date")], "baseCurrency": ["is": GraphQLVariable("baseAddress")], "quoteCurrency": ["is": GraphQLVariable("quoteAddress")]], type: .list(.nonNull(.object(DexTrade.selections)))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(dexTrades: [DexTrade]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Ethereum", "dexTrades": dexTrades.flatMap { (value: [DexTrade]) -> [ResultMap] in value.map { (value: DexTrade) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Trades on Ethereum DEX Smart Contracts
      public var dexTrades: [DexTrade]? {
        get {
          return (resultMap["dexTrades"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [DexTrade] in value.map { (value: ResultMap) -> DexTrade in DexTrade(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [DexTrade]) -> [ResultMap] in value.map { (value: DexTrade) -> ResultMap in value.resultMap } }, forKey: "dexTrades")
        }
      }

      public struct DexTrade: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["EthereumDexTrades"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("timeInterval", type: .object(TimeInterval.selections)),
            GraphQLField("baseCurrency", alias: "buyCurrency", type: .object(BuyCurrency.selections)),
            GraphQLField("baseAmount", alias: "buyAmount", type: .scalar(Double.self)),
            GraphQLField("baseAmount", alias: "buyAmountInUsd", type: .scalar(Double.self)),
            GraphQLField("quoteCurrency", alias: "sellCurrency", type: .object(SellCurrency.selections)),
            GraphQLField("quoteAmount", alias: "sellAmountInUsd", type: .scalar(Double.self)),
            GraphQLField("tradeAmount", arguments: ["in": "USD"], type: .scalar(Double.self)),
            GraphQLField("quoteAmount", alias: "volume", type: .scalar(Double.self)),
            GraphQLField("count", alias: "trades", type: .scalar(Int.self)),
            GraphQLField("quotePrice", alias: "high", arguments: ["calculate": "maximum"], type: .scalar(Double.self)),
            GraphQLField("quotePrice", alias: "low", arguments: ["calculate": "minimum"], type: .scalar(Double.self)),
            GraphQLField("minimum", alias: "open", arguments: ["of": "block", "get": "quote_price"], type: .scalar(String.self)),
            GraphQLField("maximum", alias: "close", arguments: ["of": "block", "get": "quote_price"], type: .scalar(String.self)),
            GraphQLField("quotePrice", type: .scalar(Double.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(timeInterval: TimeInterval? = nil, buyCurrency: BuyCurrency? = nil, buyAmount: Double? = nil, buyAmountInUsd: Double? = nil, sellCurrency: SellCurrency? = nil, sellAmountInUsd: Double? = nil, tradeAmount: Double? = nil, volume: Double? = nil, trades: Int? = nil, high: Double? = nil, low: Double? = nil, `open`: String? = nil, close: String? = nil, quotePrice: Double? = nil) {
          self.init(unsafeResultMap: ["__typename": "EthereumDexTrades", "timeInterval": timeInterval.flatMap { (value: TimeInterval) -> ResultMap in value.resultMap }, "buyCurrency": buyCurrency.flatMap { (value: BuyCurrency) -> ResultMap in value.resultMap }, "buyAmount": buyAmount, "buyAmountInUsd": buyAmountInUsd, "sellCurrency": sellCurrency.flatMap { (value: SellCurrency) -> ResultMap in value.resultMap }, "sellAmountInUsd": sellAmountInUsd, "tradeAmount": tradeAmount, "volume": volume, "trades": trades, "high": high, "low": low, "open": `open`, "close": close, "quotePrice": quotePrice])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Time interval
        public var timeInterval: TimeInterval? {
          get {
            return (resultMap["timeInterval"] as? ResultMap).flatMap { TimeInterval(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "timeInterval")
          }
        }

        /// Base currency
        public var buyCurrency: BuyCurrency? {
          get {
            return (resultMap["buyCurrency"] as? ResultMap).flatMap { BuyCurrency(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "buyCurrency")
          }
        }

        public var buyAmount: Double? {
          get {
            return resultMap["buyAmount"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "buyAmount")
          }
        }

        public var buyAmountInUsd: Double? {
          get {
            return resultMap["buyAmountInUsd"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "buyAmountInUsd")
          }
        }

        /// Quote currency
        public var sellCurrency: SellCurrency? {
          get {
            return (resultMap["sellCurrency"] as? ResultMap).flatMap { SellCurrency(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "sellCurrency")
          }
        }

        public var sellAmountInUsd: Double? {
          get {
            return resultMap["sellAmountInUsd"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "sellAmountInUsd")
          }
        }

        public var tradeAmount: Double? {
          get {
            return resultMap["tradeAmount"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "tradeAmount")
          }
        }

        public var volume: Double? {
          get {
            return resultMap["volume"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "volume")
          }
        }

        public var trades: Int? {
          get {
            return resultMap["trades"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "trades")
          }
        }

        public var high: Double? {
          get {
            return resultMap["high"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "high")
          }
        }

        public var low: Double? {
          get {
            return resultMap["low"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "low")
          }
        }

        public var `open`: String? {
          get {
            return resultMap["open"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "open")
          }
        }

        public var close: String? {
          get {
            return resultMap["close"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "close")
          }
        }

        public var quotePrice: Double? {
          get {
            return resultMap["quotePrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "quotePrice")
          }
        }

        public struct TimeInterval: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["TimeInterval"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("day", arguments: ["format": "%FT%TZ", "count": GraphQLVariable("interval")], type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(day: String) {
            self.init(unsafeResultMap: ["__typename": "TimeInterval", "day": day])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var day: String {
            get {
              return resultMap["day"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "day")
            }
          }
        }

        public struct BuyCurrency: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Currency"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
              GraphQLField("address", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(symbol: String, address: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Currency", "symbol": symbol, "address": address])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Currency symbol
          public var symbol: String {
            get {
              return resultMap["symbol"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
            }
          }

          /// Token Smart Contract Address
          public var address: String? {
            get {
              return resultMap["address"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "address")
            }
          }
        }

        public struct SellCurrency: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Currency"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
              GraphQLField("address", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(symbol: String, address: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Currency", "symbol": symbol, "address": address])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Currency symbol
          public var symbol: String {
            get {
              return resultMap["symbol"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
            }
          }

          /// Token Smart Contract Address
          public var address: String? {
            get {
              return resultMap["address"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "address")
            }
          }
        }
      }
    }
  }
}
