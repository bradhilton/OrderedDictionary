# OrderedDictionary

`OrderedDictionary` is a native Swift ordered dictionary. It has the behavior and features of `Dictionary` and `Array` in one abstract type.
```swift
var person: OrderedDictionary<String, String> = ["firstName" : "John"]
person+= ["lastName", "Smith"] // ["firstName": "John", "lastName": "Smith"]
person["firstName"] = "Jake" // ["firstName": "Jake", "lastName": "Smith"]
person[0] = ("bestFriend", "Bob Miller") // ["bestFriend", "Bob Millter", "firstName": "Jake", "lastName": "Smith"]
person["lastName"] // "Smith"
person[1] // ("firstName", "Jake")
```

## Installation

### Swift Package Manager
You can build `OrderedDictionary` using the [Swift Package Manager](https://github.com/apple/swift-package-manager). Just include `OrderedDictionary` as a package in your dependencies:
```
.Package(url: "https://github.com/bradhilton/OrderedDictionary.git", majorVersion: 1)
```
Be sure to import the module at the top of your .swift files:
```swift
import OrderedDictionary
```

<!--### CocoaPods-->

<!--`OrderedDictionary` is available through [CocoaPods](http://cocoapods.org). To install, simply include the following lines in your podfile:-->
<!--```ruby-->
<!--use_frameworks!-->
<!--pod 'SwiftOrderedDictionary'-->
<!--```-->
<!--Be sure to import the module at the top of your .swift files:-->
<!--```swift-->
<!--import SwiftOrderedDictionary-->
<!--```-->
<!--### Carthage-->
<!--`OrderedDictionary` is available through [Carthage](https://github.com/Carthage/Carthage). Just add the following to your cartfile:-->
<!--```-->
<!--github "bradhilton/OrderedDictionary"-->
<!--```-->
<!--Be sure to import the module at the top of your .swift files:-->
<!--```swift-->
<!--import OrderedDictionary-->
<!--```-->

## Author

Brad Hilton, brad@skyvive.com

## License

`OrderedDictionary` is available under the MIT license. See the LICENSE file for more info.
