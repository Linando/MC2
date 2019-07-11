import UIKit




class ViewController: UIViewController {
    
    //var stocks = [Stock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchJSON()
    }
    
    
    struct MetaData: Decodable {
        let symbol: String
        
        private enum CodingKeys: String, CodingKey{
            case symbol = "2. Symbol"
        }
    }
    
    struct stockDate: Decodable {
        let open: String
        let high: String
        let low: String
        let close: String
        let volume: String
        
        
        private enum CodingKeys: String, CodingKey{
            case open = "1. open"
            case high = "2. high"
            case low = "3. low"
            case close = "4. close"
            case volume = "5. volume"
        }
    }
    
    struct TimeSeries: Decodable {
        var stockDate: stockDate
        var stockDate2: stockDate
        
        private enum CodingKeys: String, CodingKey{
            case stockDate = "2019-07-08"
            case stockDate2 = "2019-07-05"
        }
    }
    
    struct Stock: Decodable {
        let metaData: MetaData
        let timeSeries: TimeSeries
        
        private enum CodingKeys: String, CodingKey{
            case metaData = "Meta Data"
            case timeSeries = "Time Series (Daily)"
        }
    }
    
    fileprivate func fetchJSON()
    {
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=BBCA&apikey=V8BKL6RTFGQV5HZ6"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do{
                let stocks = try JSONDecoder().decode(Stock.self, from: data)
                print("Stock:", stocks.metaData.symbol)
                print("Close:", stocks.timeSeries.stockDate.close)
                print("High:", stocks.timeSeries.stockDate.high)
                print("Low:", stocks.timeSeries.stockDate.low)
                print("Open:", stocks.timeSeries.stockDate.open)
                print("Volume:", stocks.timeSeries.stockDate.volume)
                //print(stocks)
                
            } catch let jsonErr{
                print("Error serializing json: ", jsonErr)
            }
            
            }.resume()
        
        
        
    }
    
}
//
//if let err = err{
//    print("Failed to fetch data: ", err)
//    return
//}
