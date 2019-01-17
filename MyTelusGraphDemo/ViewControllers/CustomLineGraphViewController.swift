import Foundation
import UIKit
import Graphs

internal class CustomLineGraphViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    @IBOutlet private weak var lineGraph: LineGraphView!
    
    // MARK: Life Cycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        // LINE GRAPH
        initializeLineGraph()
        addLineGraphData()
    }
    
    // MARK: Private Methods
    
    private func initializeLineGraph() {
        
        let verticalAxisConfig = NumericGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Y Axis: Your usage")
        
        let horizontalAxisConfig = NumericGraphAxisConfig(minValue: 0, maxValue: 30, numberOfSegments: 6, unitOfMeasure: nil, title: "X Axis: Bill cycle days")
        
        let graph = LineGraph(yConfig: verticalAxisConfig, xConfig: horizontalAxisConfig)
        lineGraph.initializeLineGraph(graph, gridType: .vertical)
    }
    
    private func addLineGraphData() {
        let dataPoints = [
            LineGraphData(x: 0, y: 0),
            LineGraphData(x: 20, y: 8)
        ]
        
        lineGraph.drawLine(title: "Fist Data", data: dataPoints, color: .magenta, lineWidth: 1.5, animateWithDuration: 0.6)
    }
    
    // MARK: IBAction

    @IBAction func test(_ sender: Any) {
        
    }
}
