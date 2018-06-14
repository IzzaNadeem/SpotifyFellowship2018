//: Playground - noun: a place where people can play

import UIKit
//Question 1 -- sortByStrings(s,t): Sort the letters in the string s by the order they occur in the string t. You can assume t will not have repetitive characters. For s = "weather" and t = "therapyw", the output should be sortByString(s, t) = "theeraw". For s = "good" and t = "odg", the output should be sortByString(s, t) = "oodg".

func twoStrings(s: String,t: String) -> String {
    var orderDict = [Character:Int]()
    var sortedString = ""
    for char in s {
        if orderDict[char] == nil {
            orderDict[char] = 1
        } else {
            orderDict[char]! = orderDict[char]! + 1
        }
    }
    print(orderDict)
    for char in t {
        if orderDict[char] != nil {
            sortedString.append(String(repeating: char, count: orderDict[char]!))
        }
    }
    return sortedString
}

twoStrings(s: "weather", t: "therapyw")

//How I tried to do this first then realized there is a better way to do this that has better runtime bigO
//func twoStrings(stringOne: String, stringTwo: String) -> String {
//    var stringTwoCopy = stringTwo
//    var returnString = ""
//    for letter in stringOne {
//        for letter2 in stringTwoCopy {
//            if letter == letter2 {
//                returnString.append(letter)
//            }
//        }
//    }
//    print(returnString)
//    return returnString
//}
//twoStrings(stringOne: "odg", stringTwo: "good")
