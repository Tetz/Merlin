//
//  ContentView.swift
//  Merlin
//
//  Created by t on 2021/06/10.
//
//

import Charts
import SwiftUI
import Apollo
import Foundation

struct ContentView: View {
    
    @State var textEntered: String
    
    var body: some View {
        VStack() {
        TextField("Type your token address", text: $textEntered)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
        Chart()
        Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(textEntered: "0xda360309c59cb8c434b28a91b823344a96444278")
    }
}

struct Chart : UIViewRepresentable {
    
    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.data = addData(param: [])
        return chart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        var vals: [ChartDataEntry] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -6, to: endDate)!
        var days: [String] = []
        let xAxisFormatter = DateFormatter()
        xAxisFormatter.dateFormat = "d.MMM"
        for i in 0...6 {
            let day = Calendar.current.date(byAdding: .day, value: -i, to: endDate)!
            days.append(xAxisFormatter.string(from: day))
        }
        let sortedDays = Array(days.reversed())
        
        Network.shared.apollo.fetch(query: TokenQuery(date: [formatter.string(from: startDate), formatter.string(from: endDate)], baseAddress: "0xda360309c59cb8c434b28a91b823344a96444278", quoteAddress: "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c", interval: 1)) { result in
          switch result {
          case .success(let graphQLResult):
            let tokens = graphQLResult.data?.ethereum?.dexTrades
            
            var x = 0
            for token in tokens ?? []{
                let tradeAmount = Double(token.tradeAmount ?? 0)
                let buyAmountInUsd = Double(token.buyAmountInUsd ?? 0)
                if(buyAmountInUsd != 0) {
                    let price = tradeAmount / buyAmountInUsd
                    // print(price)
                    vals.append(ChartDataEntry(x: Double(x), y: price))
                    x += 1
                }
                uiView.data = addData(param: vals)
                uiView.xAxis.valueFormatter = IndexAxisValueFormatter(values:sortedDays)
                uiView.xAxis.granularity = 1
            }
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
    }
    
    func addData(param: [ChartDataEntry]) -> LineChartData{
        let data: LineChartData = LineChartData()
        let dataSet = LineChartDataSet(entries: param, label: "DataSet 1")
        dataSet.colors = [NSUIColor.green]
        dataSet.label = "USD"
        dataSet.axisDependency = .left

        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.circleRadius = 3
        dataSet.fillAlpha = 1
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = .green
        dataSet.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 0)
        dataSet.drawCircleHoleEnabled = false
        data.addDataSet(dataSet)
        
        
        return data
    }
    
    typealias UIViewType = LineChartView
    
}


