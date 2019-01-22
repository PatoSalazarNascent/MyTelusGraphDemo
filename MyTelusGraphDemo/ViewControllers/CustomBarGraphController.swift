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
        
        let xAxis = CategoryGraphAxisConfig(categoryValues: ["Pato", "Jules", "Elias", "Grandma"], title: "Another Title")
        
        let barGraph = BarGraph(yConfig: yAxis, xConfig: xAxis)
        
        graphView.initializeBarGraph(graph: barGraph, gridType: .none)
    }
    
    private func addData() {
        
        let graphData = [
            BarGraphData(x: "Pato", y: 0),
            BarGraphData(x: "Jules", y: 10),
            BarGraphData(x: "Elias", y: 6),
            BarGraphData(x: "Grandma", y: 7.5)
        ]
        
        graphView.drawBars(title: "Some Shit", data: graphData, color: UIColor.cyan, barWidth: 15, withAnimationDuration: 1.5, animationType: .sequence)
    }
}
