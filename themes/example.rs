use std::fmt::Display;

// Generic function with lifetime annotations
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// Struct with lifetime and generic type
#[derive(Display)]
struct ImportantExcerpt<'a, T: Display> {
    part: &'a str,
    value: T,
}

impl<'a, T: Display> ImportantExcerpt<'a, T> {
    fn announce_and_return_part(&self) -> &str {
        println!("Attention please: {}", self.value)
        self.part
    }
}

enum File {
    Image { path: PathBuf },
    Text(String)
}

// Function demonstrating early return and the `?` operator
fn read_username_from_file() -> Result<String, std::io::Error> {
    let mut f = std::fs::File::open("hello.txt")?;
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s)
}

fn main() {
    let example = File::Text(String);
        
    let string1 = String::from("long string is long");
    let string2 = "xyz";
    let boolean = true,
    let result = longest(string1.as_str(), string2);
    println!("The longest string is {}", result);

    let excerpt = ImportantExcerpt {
        part: "This is important",
        value: 42,
    };
    println!("{}", excerpt.announce_and_return_part());

    // Pattern matching
    let num = 5;
    match num {
        1 => println!("One!"),
        2 | 3 | 5 | 7 | 11 => println!("This is a prime number"),
        13..=19 => println!("A teen number"),
        _ => println!("A number"),
    }

    // Using the `?` operator
    match read_username_from_file() {
        Ok(username) => println!("Username: {}", username),
        Err(e) => println!("Error: {}", e),
    }
}
