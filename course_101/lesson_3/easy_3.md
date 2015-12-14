#####1.) Show an easier way to write this array:
```ruby
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
```

```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```

#####2.) How can we add the family pet "Dino" to our usual array:
```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```

```ruby
flintstones << 'Dino'
```

#####3.) In the previous exercise we added Dino to our array like this:
```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino"
```

We could have used either `Array#concat` or `Array#push` to add Dino to the family.

How can we add multiple items to our array? (Dino and Hoppy)

```ruby
flintstones << 'Dino' << 'Hoppy'
```

#####4.) Shorten this sentence:
```ruby
advice = "Few things in life are as important as house training your pet dinosaur."
```

...remove everything starting from "house".

Review the `String#slice!` documentation, and use that method to make the return value "Few things in life are as important as ". But leave the advice variable as "house training your pet dinosaur.".

```ruby
advice.slice!(0, advice.index('house'))
```

As a bonus, what happens if you use the `String#slice` method instead?

The orginal string `advice` still contains ""Few things in life are as important as "

#####5.) Write a one-liner to count the number of lower-case 't' characters in the following string:
```ruby
statement = "The Flintstones Rock!"
```

```ruby
statement.count('t')
```

#####6.) Back in the stone age (before CSS) we used spaces to align things on the screen. If we had a 40 character wide table of Flintstone family members, how could we easily center that title above the table with spaces?
```ruby
title = "Flintstone Family Members"
```

```ruby
title.center(40)
```