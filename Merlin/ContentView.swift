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

struct ContentView: View {
    
    @State var textEntered: String
    
    var body: some View {
        VStack() {
        TextField("Type your token address", text: $textEntered)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
        Bar()
        Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(textEntered: "0xda360309c59cb8c434b28a91b823344a96444278")
    }
}

struct Bar : UIViewRepresentable {
    
    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.data = addData()
        return chart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> LineChartData{
        print("=== Debug ===")
        Network.shared.apollo.fetch(query: TokenQuery(date: ["2021-05-15","2021-06-11"], baseAddress: "0xda360309c59cb8c434b28a91b823344a96444278", quoteAddress: "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c", interval: 1)) { result in
          switch result {
          case .success(let graphQLResult):
            print("Success! Result: \(graphQLResult)")
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
        
        let count = 10
        let range = UInt32(100)
        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
             let val = Double(arc4random_uniform(range) + 50)
             return ChartDataEntry(x: Double(i), y: val)
         }
        
        let data = LineChartData()
        let dataSet = LineChartDataSet(entries: yVals1, label: "DataSet 1")
        dataSet.colors = [NSUIColor.green]
        dataSet.label = "My Data"
        dataSet.axisDependency = .left

        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.circleRadius = 3
        dataSet.fillAlpha = 1
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = .white
        dataSet.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 0)
        dataSet.drawCircleHoleEnabled = false
        
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = LineChartView
    
}

