//: Playground - noun: a place where people can play

import UIKit
//Question 2 -- decodeString(s): Given an encoded string, return its corresponding decoded string.
//The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is repeated exactly k times. Note: k is guaranteed to be a positive integer.
//
//For s = "4[ab]", the output should be decodeString(s) = "abababab"
//For s = "2[b3[a]]", the output should be decodeString(s) = "baaabaaa"

struct Stack<T> {
    
    private var array: [T] = []
    
    mutating func push(_ element: T) {
        
        array.append(element)
    }
    mutating func pop() -> T? {
        
        return array.popLast()
    }
    func peek() -> T? {
        return array.last
    }
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    mutating func concatenateString(element: String) -> String? {
        var mutatedArray = ""
        if self.array.isEmpty {
            return element
        }
        guard let lastElement = array.popLast() as? String else { print("append failed"); return nil }
        
        mutatedArray = lastElement + element
        
        return mutatedArray
    }
    
}

extension Character {
    var isInt: Bool {
        return Int(String(self)) != nil
    }
}

func decodeString(encodedString: String) -> String {
    var lettersStack = Stack<String>()
    var frequencyStack = Stack<Int>()
    var lettersJoined = ""
    var numbersJoined = ""
    var seenOpenBracket: Bool = false
    
    for char in encodedString {
        if char.isInt {
            if seenOpenBracket && !numbersJoined.isEmpty {
                frequencyStack.push(Int(numbersJoined)!)
                numbersJoined = ""
            }
            seenOpenBracket = false
            numbersJoined += String(char)
            if !lettersJoined.isEmpty {
                lettersStack.push(lettersJoined)
                lettersJoined = ""
            }
            
        }
        else if char >= "a" && char <= "z" {
            lettersJoined += String(char)
        }
        else if char == "[" {
            seenOpenBracket = true
            continue
        }
    }
    
    if !lettersJoined.isEmpty {
        lettersStack.push(lettersJoined)
    }
    if !numbersJoined.isEmpty {
        frequencyStack.push(Int(numbersJoined)!)
    }
    if lettersStack.isEmpty {
        return encodedString //if there are no letters to decode, just returrn the string
    }
    
    
    while !frequencyStack.isEmpty {
        let repeatingArray = Array(repeating: lettersStack.pop()!, count:frequencyStack.pop()!).joined()
        let decodedStr = String(repeatingArray)
        guard let concatenatedString = lettersStack.concatenateString(element: decodedStr) else {break}
        lettersStack.push(concatenatedString)
    }
    return lettersStack.pop()!
}

print(decodeString(encodedString: "4[a2[ab]]"))
