#####1.) In this hash of people and their age,
```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
```

see if there is an age present for "Spot".

```ruby
ages.key? 'Spot'
```

Bonus: What are two other hash methods that would work just as well for this solution?

```ruby
ages.any? { |k,v| k == 'Spot'}
```

```ruby
ages.include? 'Spot'
```

#####2.) Add up all of the ages from our current Munster family hash:
```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
```

```ruby
ages.values.inject(:+)
```

#####3.) In the age hash:
```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
```

throw out the really old people (age 100 or older).

```ruby
ages.select { |k,v| v < 100 }
```

#####4.) Starting with this string:
```ruby
munsters_description = "The Munsters are creepy in a good way."
```

Convert the string in the following ways (code will be executed on original munsters_description above):

```ruby
"The munsters are creepy in a good way."
"tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
"the munsters are creepy in a good way."
"THE MUNSTERS ARE CREEPY IN A GOOD WAY."
```

```ruby
munsters_description.capitalize!
munsters_description.swapcase!
munsters_description.downcase!
munsters_description.upcase!
```

#####5.) We have most of the Munster family in our age hash:
```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
```

add ages for Marilyn and Spot to the existing hash

```ruby
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
```

```ruby
additional_ages.each { |k,v| ages[k] = v }
```

#####6.) Pick out the minimum age from our current Munster family hash:
```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
```

```ruby
ages.values.sort.first
```

#####7.) See if the name "Dino" appears in the string below:
```ruby
advice = "Few things in life are as important as house training your pet dinosaur."
```

```ruby
advice.match 'Dino'
```

#####8.) In the array:
```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```

Find the index of the first name that starts with `"Be"`

```ruby
flintstones.index { |v| v.start_with? 'Be' }
```

#####9.) Using `array#map!`, shorten each of these names to just 3 characters:
```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```

```ruby
flintstones.map! do |v| 
  v[0..2]
end
```

#####10.) Again, shorten each of these names to just 3 characters -- but this time do it all on one line:
```ruby
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```

```ruby
flintstones.map! { |v| v[0..2] }
```