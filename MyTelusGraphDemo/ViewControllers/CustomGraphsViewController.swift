import Foundation
import UIKit

internal class CustomGraphsViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    @IBOutlet private weak var lineGraph: ChartView!
    
    // MARK: Life Cycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLineGraph()
        
        lineGraph.drawLineChart(data: [
            LineGraphData(x: 0, y: 0),
            LineGraphData(x: 2, y: 1)
        ])
    }
    
  
    
    // MARK: Internal Methods
    
    // MARK: Private Methods
    
    private func initializeLineGraph() {
        
        let horizontalAxisConfig = LineGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Data")
        
        let verticalAxisConfig = LineGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: "GB", title: "Days")
        
        let lineChart = LineGraph(xConfig: horizontalAxisConfig, yConfig: verticalAxisConfig)
        
        lineGraph.initializeLineChart(lineChart: lineChart, gridType: .horizontal)
    }
}
