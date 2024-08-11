import gleam/io
import gleam/option.{None, Option, Some}

pub type User {
  User(name: String, age: Int)
}

// Generic function
pub fn identity(a: a) -> a {
  a
}

// Algebraic data types and pattern matching
pub fn greet(user: User) -> String {
  case user {
    User(name, age) ->
      case age {
        age if age > 18 -> "Hello, " <> name <> "!"
        _ -> "Hi there, young " <> name <> "!"
      }
  }
}

// Function with early return using Option type
pub fn get_user_age(user: Option(User)) -> Option(Int) {
  case user {
    Some(User(_, age)) -> Some(age)
    None -> None
  }
}

// Using Result type for error handling
pub fn divide(x: Int, y: Int) -> Result(Int, String) {
  case y == 0 {
    True -> Error("Cannot divide by zero")
    False -> Ok(x / y)
  }
}

// Concurrency with Gleam's spawn function
pub fn concurrent_greet(user: User) {
  let _pid = spawn
  fn() {
    let greeting = greet(user)
    io.println(greeting)
  }
}

// Custom type and type aliases
pub type Point {
  Point(x: Int, y: Int)
}

type Name =
  String

// Using modules and imports
pub fn welcome(name: Name) -> String {
  "Welcome, " <> name
}

// Higher-order function
pub fn twice(f: fn(Int) -> Int, x: Int) -> Int {
  f(x) |> f
}

fn add_one(x: Int) -> Int {
  x + 1
}

pub fn main() {
  let alice = User("Alice", 30)
  let bob = User("Bob", 15)

  // Use the generic identity function
  let alice_identity = identity(alice)

  io.println(greet(alice))
  io.println(greet(bob))

  let age = get_user_age(Some(alice))
  case age {
    Some(age) -> io.println("Alice's age: " <> Int.to_string(age))
    None -> io.println("No age found")
  }

  let division_result = divide(10, 2)
  case division_result {
    Ok(result) -> io.println("Division result: " <> Int.to_string(result))
    Error(reason) -> io.println("Division failed: " <> reason)
  }

  // Concurrency example
  concurrent_greet(alice)

  // Using higher-order function
  let result = twice(add_one, 5)
  io.println("Twice add_one(5): " <> Int.to_string(result))

  // Using custom type
  let point = Point(10, 20)
  case point {
    Point(x, y) ->
      io.println(
        "Point: (" <> Int.to_string(x) <> ", " <> Int.to_string(y) <> ")",
      )
  }
}
