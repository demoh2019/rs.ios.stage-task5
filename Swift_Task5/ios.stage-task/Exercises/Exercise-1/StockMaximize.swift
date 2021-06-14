import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var buyShares = 0
        var countShares = 0
        var profit = 0
        for (index, share) in prices.enumerated() {
            let range = index...prices.count-1
            for indexShare in range {
                if share < prices[indexShare] {
                    buyShares += share
                    countShares += 1
                    break
                }
                if prices.count-1 == indexShare{
                    profit += countShares * share
                    countShares = 0
                }
            }
        }
        return profit - buyShares
    }
}
