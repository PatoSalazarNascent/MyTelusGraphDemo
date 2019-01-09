import Foundation
import UIKit

internal class CustomGraphsViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    @IBOutlet private weak var lineGraph: LineGraphView!
    @IBOutlet private weak var barGraph: BarGraphView!
    
    // MARK: Life Cycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        // LINE GRAPH
        initializeLineGraph()
        addLineGraphData()
        
        // BAR GRAPH
        
        initializeBarGraph()
    }
    
    // MARK: Private Methods
    
    private func initializeLineGraph() {
        
        let verticalAxisConfig = NumericGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Data")
        
        let horizontalAxisConfig = NumericGraphAxisConfig(minValue: 0, maxValue: 30, numberOfSegments: 6, unitOfMeasure: nil, title: "Days")
        
        let graph = LineGraph(yConfig: verticalAxisConfig, xConfig: horizontalAxisConfig)
        lineGraph.initializeLineGraph(lineChart: graph, gridType: .none)
    }
    
    private func addLineGraphData() {
        let dataPoints = [
            LineGraphData(x: 4, y: 0),
            LineGraphData(x: 6, y: 2),
            LineGraphData(x: 8, y: 6.5)
        ]
        
        lineGraph.drawLine(data: dataPoints, color: .red, lineWidth: 2, animateWithDuration: 1)
        lineGraph.addGraphFill(data: dataPoints, color: UIColor.purple.withAlphaComponent(0.5), animateWithDuration: 2)
    }
    
    private func initializeBarGraph() {
        
        let verticalAxisConfig = NumericGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Data")
        
        let horizontalAxisConfig = CategoryGraphAxisConfig(categoryValues: ["Pepsi", "Coca Cola", "Fanta", "Sprite", "RC", "Zuko"], title: "Pop Brands")
    
        let graph = BarGraph(yConfig: verticalAxisConfig, xConfig: horizontalAxisConfig)
        barGraph.initializeBarGraph(graph: graph, gridType: .vertical)
    }
    
    // MARK: IBAction

    @IBAction func test(_ sender: Any) {

    }
}
