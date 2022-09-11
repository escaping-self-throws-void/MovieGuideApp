# MovieGuide App



MBC Movie Guide clone with english and arabic localizations. Browse upcoming movies for a selected date and add a reminder to your calendar.

## Description


### Sign Up & Login Screens
* _
* _
* _

![SignUpLogin](https://user-images.githubusercontent.com/24648375/188487992-63b5c06e-a9b5-4eb7-8498-c85bd46b3c54.gif)

### Timeline Screen
* _
* _
* _

![Timeline+Date.gif]


### Movie Details Screen
* _
* _

![Details+Share.gif]

### Add reminder to your Calendar
* _
* _

![Reminder.gif]

### Movie Details Screen
* _
* _

![Details+Share.gif]

## Tools used

### Language and framework

* Swift 
* UIKit

### Design Pattern

* MVVM 
* CleanSwift (other branch)

### Concepts

* SOLID
* OOP
* POP
* Dependency injection

### Dependencies

* RxSwift (other branch)

## In-depth 

### Model 

Codable model used to decode from JSON.

```Swift
struct WeatherData: Codable {
    let list: [List]
    let city: City
}
...
```
### Generic Async/Await Network Layer

Protocol Network Service with default implementation in extension using generic type, URLSession and async/await, introduced in Swift 5.5.


## RxSwift

Second branch created to try RxSwift. 


Succeeded to implement logic from main branch.

## Authors

 Paul Matar
 [@p_a_matar](https://twitter.com/p_a_matar)



## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments


[Open Weather API](https://openweathermap.org)
