//: Playground - noun: a place where people can play

import UIKit

var str = "Hello,"
var newString = str + " Rob!"

/* Working with Strings */

for c in str.characters{
    print(c)
}

let newTypeString = NSString(string: newString) //NSStrings have functions that regular Strings don't have

print(newTypeString.substring(to:5)) //up to and including the 5th character (ends at index 4)
newTypeString.substring(from:4)
NSString(string: newTypeString.substring(from:6)).substring(to:3) //all indices
newTypeString.substring(with: NSRange(location:6,length:3))

if newTypeString.contains("Rob"){
    print("newTypeString contains Rob!")
}

newTypeString.components(separatedBy:" ")
newTypeString.uppercased
newTypeString.lowercased
