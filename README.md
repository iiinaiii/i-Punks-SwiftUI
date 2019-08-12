# i-Punks-SwiftUI

Sample repository for learning SwiftUI & Combine.
This repository is a rewrite of the following MVVM (RxSwift) app with SwiftUI and Combine
https://github.com/iiinaiii/i-Punks

<img src="https://user-images.githubusercontent.com/16633277/62879028-37619780-bd65-11e9-893e-800fdf45772d.png" width="240px">     <img src="https://user-images.githubusercontent.com/16633277/62879082-5102df00-bd65-11e9-8dcf-b7c3c68767d0.png" width="240px">

# Environment
Xcode11 beta5

# Architecture overview
## MVVM + Layerd architecture 
<img src="https://user-images.githubusercontent.com/16633277/62879948-3467a680-bd67-11e9-8253-e6716a2d9777.png" width="480px">

### MVVM
* Same as common MVVM, it divides the responsibilities into View/ViewModel/Model

### Layered architecture
* Model layer is divided into three, UseCase/Domain/Infra, according to each responsibility.

### Combine
* Combine is used to pass the data of each layer.
