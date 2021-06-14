import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func GetSumAllKilometres(items: [Supply])->[Int]{
        var SupplyValue = Array(repeating: 0, count: maxWeight+1)
        var oldStay = Array(repeating: 0, count: maxWeight+1)
        for item in items {
            for weight in 0...maxWeight{
                if weight >= item.weight {
                    SupplyValue[weight] = max(oldStay[weight], item.value+oldStay[weight-item.weight])
                }
            }
            oldStay = SupplyValue
        }
        return SupplyValue
    }
    
    func findMaxKilometres() -> Int {
        guard maxWeight <= 2500 && maxWeight > 0 else {
            return 0
        }
        let foodSum = GetSumAllKilometres(items: foods)
        let waterSum = GetSumAllKilometres(items: drinks)
        var result = 0
        for weight in 0...maxWeight{
            result = max(result, min(foodSum[weight], waterSum[maxWeight-weight]))
        }
        return result
    }
}
