// Playground - noun: a place where people can play

import Cocoa

//var str = "Hello, playground"
//var s = "aaaaaaaaa"
//let num = 123.00
//
//let widthlabel = str + String(num)
//let apples = 3
//let oranges = 5
//let appleSummary = "I have \(apples) apples"
//let fruitSummary = "I have \(apples + oranges) pieces of fruit"
//
//var occupations = ["Malcolm":"Captain", "Kaylee":"Mechanic"]
//occupations["jayne"] = "Public Relations"
//
//let emptyArray = String[]()
//let emptyDictionary = Dictionary<String, String>()

//let individualScores = [74,43,103,87,12]
//var teamScore = 0
//for score in individualScores{
//    if score > 50{
//        teamScore += 3
//    } else {
//        teamScore += 1
//    }
//}
//
//teamScore
//
//
//
//var optionalString:String?="hello"
//optionalString == nil
//
//var optionalName:String?="John Appleseed"
//var geeting = "hello"
//if let name = optionalName {
//    geeting = "hello, \(name)"
//}


//
//let vegetable = "red pepper"
//switch vegetable {
//    case "celery":
//    let vegetableComment = "Add some raisins and make ants on a log."
//    
//    case "cucumber","watercress":
//    let vegetableComment = "That would make a good tea sandwich"
//    
//    case let x where x.hasSuffix("pepper"):
//    let vegetableComment = "Is it a spicy \(x)?"
//    
//    default:
//    let vegetableComment = "Everything tastes good in soup."
//}


let interestingNumbers = [
    "Prime":[2,3,5,7,11,13],
    "Fibonacci":[1,1,2,3,5,8],
    "Square":[1,4,9,16,25],
]

var largest = 0
for (kind, numbers) in interestingNumbers{
    for number in numbers {
        if number > largest{
            largest = number
            kind
        }
    }
}


