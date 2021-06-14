import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        for word in message{
            if !("0"..."9" ~= word || "a"..."z" ~= word.lowercased() || "[" == word || "]" == word) {
                return message
            }
        }
        return unpack(pack: message)
    }
    
    func unpack(pack: String) -> String{
        var packs = pack
        var number = ""
        var firstWord = 0
        var firstNumber = 0
        var countWord = 0
        for (index, word) in pack.enumerated(){
            if "0"..."9" ~= word && countWord == 0 {
                if firstNumber == 0 {
                    firstNumber = index
                }
                number.append(word)
            }
            if "[" == word {
                if countWord == 0 {
                    firstWord = index
                }
                countWord += 1
            }
            if "]" == word && countWord == 1{
                if !(1...300 ~= Int(number) ?? 1) {
                    return ""
                }
                var startIndex = pack.index(pack.startIndex, offsetBy: firstWord+1)
                let endIndex = pack.index(pack.startIndex, offsetBy: index)
                let substring = String(pack[startIndex..<endIndex])
                let result = unpack(pack: substring)
                startIndex = pack.index(pack.startIndex, offsetBy: firstNumber)
                if let range = packs.range(of: String(pack[startIndex...endIndex])){
                    packs.replaceSubrange(range, with: String(repeating: result, count: Int(number) ?? 1))
                }
                number = ""
                countWord = 0
                firstNumber = 0
            }else if ("]" == word && countWord > 1){
                countWord -= 1
            }
        }
        return packs
    }
}
