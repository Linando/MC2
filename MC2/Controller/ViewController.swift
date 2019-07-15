import UIKit

class ViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
    }
}

func fetchJSON()
{
    for i in 0...blueChipSymbol.count-1
    {
        let symbol = blueChipSymbol[i]
        let key = APIKey[i%5]
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=\(symbol)&apikey=\(key)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do{
                let decodedStock = try JSONDecoder().decode(Stock.self, from: data)
                var temp = decodedStock.timeSeries.stockDates.sorted(by: { $0.date > $1.date })
                
                for i in 0...0{
                    print(symbol + " " + temp[i].date + " Price: $" + temp[i].open + " " + key)
                }
                
            } catch let jsonErr{
                print("Error serializing json: ", jsonErr)
            }}.resume()
    }
    
}


