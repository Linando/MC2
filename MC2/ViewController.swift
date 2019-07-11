import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
    }
}

fileprivate func fetchJSON()
{
    for i in 0...blueChipAPI.count-1
    {
        let symbol = blueChipAPI[i]
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=\(symbol)&apikey=V8BKL6RTFGQV5HZ6"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do{
                let decodedStock = try JSONDecoder().decode(Stock.self, from: data)
                var temp = decodedStock.timeSeries.stockDates.sorted(by: { $0.date > $1.date })
                
                for i in 0...0{
                    print(symbol + " " + temp[i].date)
                }
                
            } catch let jsonErr{
                print("Error serializing json: ", jsonErr)
            }}.resume()
    }
    
}


