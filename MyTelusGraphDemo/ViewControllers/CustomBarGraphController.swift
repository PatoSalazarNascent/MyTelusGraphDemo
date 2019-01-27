import Foundation
import UIKit
import Graphs

internal class CustomBarGraphController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var graphView: BarGraphView!
    
    // MARK: Life Cycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        initBarGraph()
        addData()

    }
    
    // MARK: Private
    
    private func initBarGraph() {
        
        let yAxis = NumericGraphAxisConfig(minValue: 0, maxValue: 10, numberOfSegments: 5, unitOfMeasure: nil, title: "Some Title")
        
        let xAxis = CategoryGraphAxisConfig(categoryValues: ["Pato", "Jules"], title: "Another Title")
        
        let barGraph = BarGraph(yConfig: yAxis, xConfig: xAxis)
        
        graphView.initializeBarGraph(graph: barGraph, gridType: .vertical)
    }
    
    private func addData() {
        
        let graphData = [
            BarGraphData(x: "Pato", y: 5),
            BarGraphData(x: "Jules", y: 10)
        ]
        
        graphView.drawBars(title: "Some Shit", data: graphData, color: UIColor.cyan, barWidth: 15, withAnimationDuration: 1.5, animationType: .none)
    }
}
