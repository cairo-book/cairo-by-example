#[derive(Copy, Drop, Debug)]
enum Food {
    Apple,
    Carrot,
    Potato,
}

#[derive(Copy, Drop, Debug)]
struct Peeled {
    food: Food,
}

#[derive(Copy, Drop, Debug)]
struct Chopped {
    food: Food,
}

#[derive(Copy, Drop, Debug)]
struct Cooked {
    food: Food,
}

// Peeling food. If there isn't any, then return `None`.
// Otherwise, return the peeled food.
fn peel(food: Option<Food>) -> Option<Peeled> {
    match food {
        Some(food) => Some(Peeled { food }),
        None => None,
    }
}

// Chopping food. If there isn't any, then return `None`.
// Otherwise, return the chopped food.
fn chop(peeled: Option<Peeled>) -> Option<Chopped> {
    match peeled {
        Some(Peeled { food }) => Some(Chopped { food }),
        None => None,
    }
}

// Cooking food. Here, we showcase `map()` instead of `match` for case handling.
fn cook(chopped: Option<Chopped>) -> Option<Cooked> {
    chopped.map(|chopped: Chopped| Cooked { food: chopped.food })
}

// A function to peel, chop, and cook food all in sequence.
// We chain multiple uses of `map()` to simplify the code.
fn process(food: Option<Food>) -> Option<Cooked> {
    food
        .map(|f| Peeled { food: f })
        .map(|peeled| Chopped { food: peeled.food })
        .map(|chopped| Cooked { food: chopped.food })
}

// Check whether there's food or not before trying to eat it!
fn eat(food: Option<Cooked>) {
    match food {
        Some(food) => println!("Mmm. I love {:?}", food),
        None => println!("Oh no! It wasn't edible."),
    }
}

fn main() {
    let apple = Some(Food::Apple);
    let carrot = Some(Food::Carrot);
    let potato = None;

    let cooked_apple = cook(chop(peel(apple)));
    let cooked_carrot = cook(chop(peel(carrot)));
    // Let's try the simpler looking `process()` now.
    let cooked_potato = process(potato);

    eat(cooked_apple);
    eat(cooked_carrot);
    eat(cooked_potato);
}
