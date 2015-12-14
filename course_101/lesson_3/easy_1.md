#####1.) What would you expect the code below to print out?
```ruby
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers
```
I would expect [1, 2, 3] because its returning an array of unique values.


#####2.) Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:
1. what is `!=` and where should you use it?
    
    Not equal to. Should be used in condition statements

2. put `!` before something, like `!user_name`
    
    This will return the opposite boolean value of the object

3. put `!` after something, like `words.uniq!`
    
    Signifies destrcutive action. The object itself will be changed in some manner

4. put `?` before something
    
    Does not have signifigant meaning. When put in front of a single character it will return that character.

5. put `?` after something
    
    Signifies that it will return a boolean value

6. put `!!` before something, like `!!user_name`
    
    converts the object to a boolean value of itself


#####3.) Replace the word "important" with "urgent" in this string:
```ruby
advice = "Few things in life are as important as house training your pet dinosaur.
```

```ruby
advice.gsub! 'important', 'urgent'
```


#####4.) The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:
```ruby
numbers = [1, 2, 3, 4, 5]
```

What does the follow method calls do (assume we reset numbers to the original array between method calls)?
```ruby
numbers.delete_at(1)
numbers.delete(1)
```
The first call will delete the number at index 1 (which is 2)

The second call will delete values of number 1 in the array


#####5.) Programmatically determine if 42 lies between 10 and 100.
```ruby
(10..100).include? 42
```


#####6.) Starting with the string:
```ruby
famous_words = "seven years ago..."
```

show two different ways to put the expected "Four score and " in front of it.

```ruby
famous_words.prepend "Four score and "
```

```ruby
famous_words = "Four score and " + famous_words
```


#####7.) Fun with gsub:
```ruby
def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep
```

This gives us a string that looks like a "recursive" method call:

```ruby
"add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"
```

If we take advantage of Ruby's `Kernel#eval` method to have it execute this string as if it were a "recursive" method call

```ruby
eval(how_deep)
```

what will be the result?

```ruby
42
```


#####8.) If we build an array like this:
```ruby
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
```
We will end up with this "nested" array:

```ruby
["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
```

Make this into an un-nested array.

```ruby
flintstones.flatten!
```


#####9.) Given the hash below
```ruby
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
```

Turn this into an array containing only two elements: Barney's name and Barney's number

```ruby
flintstones.select{ |k,v| k == "Barney"}.to_a.flatten
```


#####10.) Given the array below
```ruby
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
```

Turn this array into a hash where the names are the keys and the values are the positions in the array.

```ruby
flintstones.map.with_index{ |name, index| [name, index] }.to_h
```