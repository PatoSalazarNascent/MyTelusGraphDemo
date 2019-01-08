import Foundation
import UIKit
import Charts


internal class LibraryGraphsViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    @IBOutlet private weak var lineChartView: LineChartView!
    
    
    // MARK: Life Cycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        initLineChart()
    }
    
    // MARK: Internal Methods
    
    // MARK: Private Methods
    
    private func initLineChart() {
        let values = [
            ChartDataEntry(x: 2.0, y: 10.6),
            ChartDataEntry(x: 4.2, y: 5.1),
            ChartDataEntry(x: 7.3, y: 3.0),
            ChartDataEntry(x: 8.1, y: 5.5),
            ChartDataEntry(x: 100.0, y: 8.0)
        ]
        
        
        let set1 = LineChartDataSet(values: values, label: "DataSet 1")
        let data = LineChartData(dataSet: set1)
        
        self.lineChartView.data = data
    }
}
