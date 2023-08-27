# Coffess Bar
Aplicativo de martkplace , onde usuario pode seleiconar os na tela princiapl como tambem pesquisar pelos favoritos,ao selecionar o produto ele vai para o carrinho nesta etapa pode adiconar mais produtos então aumenta a quantidade ou descatar algum produto que esta no carrinho.
Usuario tambem po visualizar os pedidos antigos que fez no aplicativo, como tambem atualizar seu avatar


## Feature
- Arquitetura do projeto foi construida no MV, esse desing pattern diminui a complexidade e traz os beneficios do MVVM
- Priemria parte e construir os modelos( Models), depois a camada de serviço(Services) e por fim faz uma camada intermediario no caso nome era store


```swift

//Models
import Foundation

struct UsersModel: Codable {
  let id: String
  let name: String
  let email: String
  let avatarId: String
  let password: String

  private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case name
    case email
    case avatarId
    case password
  }
}


//Services

class UserWebService {
  func createUser(params: [String: Any], completion: @escaping (Result<UsersModel, NetworkError>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/users/sigin") else {
      return completion(.failure(.badUrl))
    }

    var request = URLRequest(url: url)

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    request.httpMethod = "POST"

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
    } catch {
      print(error.localizedDescription)
      completion(.failure(.invalidRequest))
    }

    URLSession.shared.dataTask(with: request) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        if let response = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
          response.forEach {
            let dictionary = $0 as? [String: String]

            let user = UsersModel(
              id: dictionary?["_id"] ?? "",
              name: dictionary?["name"] ?? "",
              email: dictionary?["email"] ?? "",
              avatarId: dictionary?["avatarId"] ?? "",
              password: dictionary?["password"] ?? ""
            )
            completion(.success(user))
          }
        } else {
          completion(.failure(.noData))
        }

      } catch {
        print(error.localizedDescription)
        completion(.failure(.noData))
      }

    }.resume()
  }

  func loginUser(params: [String: Any], completion: @escaping (Result<UsersModel, NetworkError>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/users/login") else {
      return completion(.failure(.badUrl))
    }

    var request = URLRequest(url: url)

    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    // se precisar de token
    // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //	request.setValue(Constants.API_TOKEN, forHTTPHeaderField: "Authorization")

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)

    } catch {
      print(error.localizedDescription)
      completion(.failure(.invalidRequest))
    }

    URLSession.shared.dataTask(with: request) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.badUrl))
      }

      do {
        if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
          if response["error"] != nil {
            completion(.failure(.noData))
          } else {
            let user = UsersModel(
              id: response["_id"] ?? "",
              name: response["name"] ?? "",
              email: response["email"] ?? "",
              avatarId: response["avatarId"] ?? "",
              password: response["password"] ?? ""
            )

            completion(.success(user))
          }
        }

      } catch {
        completion(.failure(.noData))
      }

    }.resume()
  }

  func updateAvatar(
    withUpateAvatar updateAvar: UpdateAvatarModel,
    andUserId userId: String,
    completion: @escaping (Result<Bool, NetworkError>) -> Void
  ) {
    guard let url = URL(string: "\(baseUrl)/users/avatar?userId=\(userId)") else {
      return completion(.failure(.badUrl))
    }

    var request = URLRequest(url: url)

    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    do {
      let jsonEncode = try JSONEncoder().encode(updateAvar)
      request.httpBody = jsonEncode
    } catch {
      print(error.localizedDescription)
      completion(.failure(.invalidRequest))
    }

    URLSession.shared.dataTask(with: request) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
        if response?["sucess"] != nil {
          completion(.success(true))
        }

      } catch {
        print(error.localizedDescription)
        completion(.failure(.invalidRequest))
      }
    }.resume()
  }
}


//Store

class StoreUsers: ObservableObject {
  @Published var loading = LoadingState.loading
  @Published var user = UsersModel(id: "", name: "", email: "", avatarId: "", password: "")

  func creatUsers(params: [String: String], completion: @escaping () -> Void) {
    UserWebService().createUser(params: params) { result in

      switch result {
      case let .success(user):

        DispatchQueue.main.async {
          self.user = user
          self.loading = .sucess
          completion()
        }

      case let .failure(error):
        print(error)
        DispatchQueue.main.async {
          self.loading = .failure
          completion()
        }
      }
    }
  }

  func loginUser(params: [String: String], completion: @escaping () -> Void) {
    UserWebService().loginUser(params: params) { result in

      switch result {
      case let .success(data):

        DispatchQueue.main.async {
          self.user = data
          self.loading = LoadingState.sucess
          completion()
        }

      case let .failure(error):

        DispatchQueue.main.async {
          self.loading = LoadingState.failure
          completion()
        }
      }
    }
  }

  func updateUserAvatar(
    withUpdateAvatar: UpdateAvatarModel,
    andUserId userId: String,
    completion: @escaping (Bool) -> Void
  ) {
    UserWebService().updateAvatar(withUpateAvatar: withUpdateAvatar, andUserId: userId) { result in

      switch result {
      case let .success(stats):

        DispatchQueue.main.async {
          completion(stats)
        }

      case let .failure(error):

        DispatchQueue.main.async {
          print(error)
          completion(false)
        }
      }
    }
  }
}


//View
//quando deseja qeu assim aparecer view carregar os store
@StateObject var storeUpdateUser = StoreUsers()
.onAppear {
        stateTabView.hiddeTabView = false
        storeAvatars.fetchAnAvatar(user.avatarId)
        storeAvatars.fetchAllAvatar()
        storeCoffess.fetchAllCoffes()
        collectionCoffee = storeCoffess.coffees
      }

```

##
- Existem N abordagem para realizar http post no swift, uma maneira mais simples e construir um model com protocolo Codable e realizar o encode dessa model outra alterantiva e enviar um dicionario de string
- Abaixo os dois modelos, [este artigo e otimo sobre uso de http post swift](https://www.appsdeveloperblog.com/http-post-request-example-in-swift/#google_vignette)


```swift

// enviando [String:Any]
var request = URLRequest(url: url)

    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    // se precisar de token
    // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //	request.setValue(Constants.API_TOKEN, forHTTPHeaderField: "Authorization")

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)

    } catch {
      print(error.localizedDescription)
      completion(.failure(.invalidRequest))
    }

    URLSession.shared.dataTask(with: request) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.badUrl))
      }

      do {
        if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
          if response["error"] != nil {
            completion(.failure(.noData))
          } else {
            let user = UsersModel(
              id: response["_id"] ?? "",
              name: response["name"] ?? "",
              email: response["email"] ?? "",
              avatarId: response["avatarId"] ?? "",
              password: response["password"] ?? ""
            )

            completion(.success(user))
          }
        }

      } catch {
        completion(.failure(.noData))
      }


//usando seu model
var request = URLRequest(url: url)

    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    do {
      let jsonEncode = try JSONEncoder().encode(updateAvar)
      request.httpBody = jsonEncode
    } catch {
      print(error.localizedDescription)
      completion(.failure(.invalidRequest))
    }

    URLSession.shared.dataTask(with: request) { data, _, error in

      guard let data = data, error == nil else {
        return completion(.failure(.noData))
      }

      do {
        let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
        if response?["sucess"] != nil {
          completion(.success(true))
        }

      } catch {
        print(error.localizedDescription)
        completion(.failure(.invalidRequest))
      }



```

## 
- Extension Swift e algo podero apliquei alguns como [spreed opator]( https://gist.github.com/cprovatas/d07226c3b8f4bd37dd6232d9ed013d6a), [max length](https://stackoverflow.com/questions/56476007/swiftui-textfield-max-length),[regex](https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift)



```swift
//spreed opeator
  func selectedOrder(_ orders: [Orders]) {
    orders.forEach { orders in
      if let index = order.cartOrder.firstIndex(where: { $0.id == orders.coffeeId }) {
        let orderRemoved = order.cartOrder.remove(at: index)
        let order = OrdersModel(
          id: orders.coffeeId,
          urlPhoto: orders.urlImage,
          quantity: orders.quantity + orderRemoved.quantity,
          price: orders.price,
          name: orders.title
        )
        auxiliaryUpdateOrder.append(order)

      } else {
        let order = OrdersModel(
          id: orders.coffeeId,
          urlPhoto: orders.urlImage,
          quantity: orders.quantity,
          price: orders.price,
          name: orders.title
        )
        auxiliaryOrder.append(order)
      }
    }

 
    let concat = auxiliaryOrder...auxiliaryUpdateOrder
    order.cartOrder.append(contentsOf: concat)
    auxiliaryOrder = []
    auxiliaryUpdateOrder = []
    stateTabView.tagSelected = 1
}

// regex
 collectionCoffee = storeCoffess.coffees.filter { regex.matches($0.name) }

//max length

TextField(
              "",
              text: Binding(
                get: {
                  searchCoffee
                }, set: { newValue, _ in
                  if let _ = newValue.lastIndex(of: "\n") {
                    searchIsFocused = false
                  } else {
                    searchCoffee = newValue
                  }
                }

              ).max(50),

```

## 
- Usei um conceito interessante para deixar o input dinamico, basicmente e o uso da propriedade .vertical, ao usar essa propriedade não ira conseguir usar o botão de reotno do teclado uma alternativa e usaro proprio Binding como abaixo
- Repara abaixo que estamos usando o wrap FocusState ele e importamente pra retirarmos o foco do teclado
- Se desejar alterar o estilo do botão do teclado pode a proprieadde  submitLabel
- Quando desejar fazer um focus por campos pode fazer um enum e assim ao implementar uma logica consigo pluar de input para inpout usando esse campo, exemplo abaixo estou usando apneas message mas poderia ter email,password e ir navaegando automatico entre os campos usando focus

- 

```swift
  @FocusState private var searchIsFocused: Bool

     TextField(
              "",
              text: Binding(
                get: {
                  searchCoffee
                }, set: { newValue, _ in
                  if let _ = newValue.lastIndex(of: "\n") {
                    searchIsFocused = false
                  } else {
                    searchCoffee = newValue
                  }
                }

              ).max(50),
              prompt: Text("Search your favorite coffee")
                .foregroundColor(ColorsApp.gray)
                .font(.custom(FontsApp.interThin, size: 17)),
              axis: .vertical
            )
            .focused($searchIsFocused)


//usando focus para varios campos e submitLabel

enum Field: Int, Hashable {
  case message
}

 TextField(placeHolderTextField, text: Binding(
        get: { valueTextField },
        set: { newValue, _ in
          if let _ = newValue.lastIndex(of: "\n") {
            focusedField = .none
            isSheetPresented = false

          } else {
            valueTextField = newValue
          }
        }
      ), axis: .vertical)
        .font(.custom(FontsApp.interRegular, size: 18))
        .foregroundColor(ColorsApp.black)
        .focused($focusedField, equals: .message)
        .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
        .background(
          RoundedRectangle(cornerRadius: 7)
            .stroke(ColorsApp.gray, lineWidth: 1)
        )
        .onAppear {
          focusedField = .message
        }
        .submitLabel(.done)


```
##
- Quando deseja criar objetos que serão compartilhados com toda aplicação usamos o enrironmentObject como exemplo abaixo


```swift
  //criando a referencia todas que estiverem englobado pela MainView terao acesso

  @StateObject var stateTabView = StateNavigationTabView()


  var body: some View {
    // maneira de navegar via codigo entre as tabs
    // alem de fazer as tagas criei um objeto que e compartilhado entre todas as views
    TabView(selection: $stateTabView.tagSelected) {
      HomeScreen(cart: cartOders, user: user, isLoggedIn: $isLoggedIn)
        .tabItem {
          Image(systemName: "house.fill")
        }

        .toolbar(stateTabView.hiddeTabView ? .hidden : .visible, for: .tabBar)
        .tag(0)

      Cart(cart: cartOders, user: user)

          .tabItem {
            Image(systemName: "cart.fill")
          }
          .tag(1)

      FavoriteOrders(order: cartOders, user: user)
        .tabItem {
          Image(systemName: "heart.fill")
        }
        .tag(2)
    }
    .edgesIgnoringSafeArea(.all)
    // tint color e icone selecionado
    .tint(ColorsApp.beige)

    .onAppear {
      let standardAppearance = UITabBarAppearance()
      standardAppearance.configureWithDefaultBackground()
      standardAppearance.backgroundColor = UIColor(
        displayP3Red: 57 / 255,
        green: 38 / 255,
        blue: 41 / 255,
        alpha: 1
      )
      UITabBar.appearance().standardAppearance = standardAppearance
      let scrollEdgeAppearance = UITabBarAppearance()
      scrollEdgeAppearance.configureWithTransparentBackground()
      UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
      scrollEdgeAppearance.backgroundColor = UIColor(
        displayP3Red: 57 / 255,
        green: 38 / 255,
        blue: 41 / 255,
        alpha: 1
      )
    }
   // colocando na raiz
    .environmentObject(stateTabView)
  }



//Home Screen
@EnvironmentObject private var stateTabView: StateNavigationTabView


 .onAppear {
        stateTabView.hiddeTabView = false
        storeAvatars.fetchAnAvatar(user.avatarId)
        storeAvatars.fetchAllAvatar()
        storeCoffess.fetchAllCoffes()
        collectionCoffee = storeCoffess.coffees
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreen(
      cart: CartObservable(),
      user: UsersModel(id: "", name: "", email: "", avatarId: "", password: ""),
      isLoggedIn: .constant(false)
    )

    .environmentObject(StateNavigationTabView())
  }
}

```

## 
- Exemplo abaixo como implementar nesting de navegação o exmplo abaixo, quando navega pra uma stack removia a tab bar e  ao retonrar dessa stack implmentava novmanete a tab bar


```swift
// implementadoa logica da tab view, imporamente usar a palavra tag com ela consigo navegar via codigo para qualquer tab


//classe StateNavigationTabView
class StateNavigationTabView: ObservableObject {
  @Published var hiddeTabView: Bool = false
  @Published var tagSelected = 0
}


//uso na main
@StateObject var stateTabView = StateNavigationTabView()

TabView(selection: $stateTabView.tagSelected) {
      HomeScreen(cart: cartOders, user: user, isLoggedIn: $isLoggedIn)
        .tabItem {
          Image(systemName: "house.fill")
        }

        .toolbar(stateTabView.hiddeTabView ? .hidden : .visible, for: .tabBar)
        .tag(0)

      Cart(cart: cartOders, user: user)

          .tabItem {
            Image(systemName: "cart.fill")
          }
          .tag(1)

      FavoriteOrders(order: cartOders, user: user)
        .tabItem {
          Image(systemName: "heart.fill")
        }
        .tag(2)
    }

 .environmentObject(stateTabView)


// Exemplo de como esconder a tab ao navegar para Details Screen
 @EnvironmentObject private var state: StateNavigationTabView


 .onAppear {
      state.hiddeTabView = true
      isAddedCart = order.cartOrder.contains(where: { $0.id == coffee.id })
    }
    .onDisappear {
      state.hiddeTabView = false
    }


//Exemplo como navegar usando as tag
@EnvironmentObject private var stateTabView: StateNavigationTabView
 
func handleBack() {
    stateTabView.tagSelected = 0
    cart.cartOrder = []
  }


```

## 
- Para limpar as stack do fluxo de navegação e não interferer com as tab implementei uma classe ObservableObject e com ela eu conseguia remover usando um exemplo do pop

```swift
//classe
class StateNavigationStack: ObservableObject {
  @Published var isActiveFinishPayment = false
  @Published var isActivePurchasePayment = false
  @Published var isLogin = false
  @Published var isSigin = false
}

// fluxo do carrinho

//Cart
@StateObject var stateStackView = StateNavigationStack()
  
 .navigationDestination(isPresented: $stateStackView.isActiveFinishPayment) {
              FinishPaymentScreen(cart: cart, tax: tax, valueTotalCart: valueTotalCart, userId: user.id)
}
.environmentObject(stateStackView)

//FinishPaymentScreen
  @EnvironmentObject private var stateStack: StateNavigationStack

.navigationDestination(isPresented: $stateStack.isActivePurchasePayment) {
            PurchaseMadeScreen(
              cart: cart,
              city: returnTextIfValueFalse(
                conditional: city.isEmpty,
                value: city,
                optionalValue: locationManager.addressUser.city
              ),
              district: returnTextIfValueFalse(
                conditional: district.isEmpty,
                value: district,
                optionalValue: locationManager.addressUser.district
              ),
              street: returnTextIfValueFalse(
                conditional: street.isEmpty,
                value: street,
                optionalValue: locationManager.addressUser.street
              ),
              streetNumber: returnTextIfValueFalse(
                conditional: streetNumber.isEmpty,
                value: streetNumber,
                optionalValue: locationManager.addressUser.numberStreet
              ),
              valueTotal: tax + valueTotalCart
            )
          }
        }

//PurschaseMadeScreen

//aqui eu matava todas e navega para as tab, dimiss elemina atual

  @EnvironmentObject private var stateStack: StateNavigationStack

  @Environment(\.dismiss) var dismiss
   .onDisappear {
        dismiss()
        stateStackView.isActiveFinishPayment = false
        stateStackView.isActivePurchasePayment = false
        stateTabView.hiddeTabView = false
      }

```

##
- Outros exemplos de usar regex e propriedade computada em swift
- Validar [email](https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift), [password](https://stackoverflow.com/questions/39284607/how-to-implement-a-regex-for-password-validation-in-swift)

```swfit

  var validateEmail: Bool {
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return returnIsValiteField(value: email, pattern: pattern)
  }


  // regex password
  var validatePassword: Bool {
    let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    return returnIsValiteField(value: password, pattern: pattern)
  }


 func returnIsValiteField(value: String, pattern: String) -> Bool {
    let range = NSRange(location: 0, length: value.utf16.count)
    do {
      let regexEmail = try NSRegularExpression(pattern: pattern)
      return regexEmail.firstMatch(in: value, range: range) != nil
    } catch {
      return false
    }
  }

```

