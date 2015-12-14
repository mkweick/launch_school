#####1.) Hashes are commonly found to be more complex than the simple one we saw earlier:
```ruby
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
```

It is often the case that each key points to another hash instead of a single value:

```ruby
munsters = { 
  "Herman" => { "age" => 32, "gender" => "male" }, 
  "Lily" => { "age" => 30, "gender" => "female" }, 
  "Grandpa" => { "age" => 402, "gender" => "male" }, 
  "Eddie" => { "age" => 10, "gender" => "male" } 
}
```

Figure out the total age of just the male members of the family.

```ruby
total_male_age = 0
munsters.each do |k,values|
  total_male_age += values["age"] if values["gender"] == "male"
end
```

#####2.) One of the most frequently used real-world string properties is that of "string substitution", where we take a hard-coded string and modify it with various parameters from our program.

Given this previously seen family hash, print out the name, age and gender of each family member:

```ruby
munsters = { 
  "Herman" => { "age" => 32, "gender" => "male" }, 
  "Lily" => { "age" => 30, "gender" => "female" }, 
  "Grandpa" => { "age" => 402, "gender" => "male" }, 
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
```

...like this:

(Name) is a (age) year old (male or female).

```ruby
munsters.each do |k,values|
  puts "#{k} is a #{values["age"]} year old #{values["gender"]}."
end
```

#####3.) In an earlier exercise we saw that depending on variables to be modified by called methods can be tricky:
```ruby
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
```

We learned that when the above "coincidentally" does what we think we wanted "depends" upon what is going on inside the method.

How can we refactor this exercise to make the result easier to predict and easier for the next programmer to maintain?

You could change the array addition in the method to `an_array_param += ["rutabaga"]` and then return both the values, then assign those values from calling the method beneath the original `my_string` and `my_array`. I didn't code this because this are extremly bad practices.

#####4.) A quick glance at the docs for the Ruby String class will have you scratching your head over the absence of any "word iterator" methods.

Our natural inclination is to think of the words in a sentence as a collection. We would like to be able to operate on those words the same way we operate on the elements of an array. Where are the `String#each_word` and the `String#map_words` methods?

A common idiom used to solve this conundrum is to use the `String#split` in conjunction with `Array#join` methods to break our string up and then put it back together again.

Use this technique to break up the following string and put it back together with the words in reverse order:

`sentence = "Humpty Dumpty sat on a wall."`

```ruby
sentence.split(/\W/).reverse.join(' ') + '.'
```

#####5.) What is the output of the following code?
```ruby
answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8
```

34. The original answer variable was never modified in place or outside a method

#####6.) One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their demographic data:
```ruby
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end
```

After writing this method, he typed the following...and before Grandpa could stop him, he hit the Enter key with his tail:

`mess_with_demographics(munsters)`

Did the family's data get ransacked, or did the mischief only mangle a local copy of the original hash? (why?)

The data has been changed permanently. This is because the method doesn't reassign the hash to a new variable, it continues to just use demo_hash which is referencing the original munsters hash which was passed in.

#####7.) Method calls can take expressions as arguments. Suppose we define a function called rps as follows, which follows the classic rules of rock-paper-scissors game, but with a slight twist that it declares whatever hand was used in the tie as the result of that tie.
```ruby
def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end
```

What is the result of the following call?

`puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")`

paper. Evaluating from inner most call first, the method will eavalute to Paper.

#####8.) Consider these two simple methods:
```ruby
def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end
```

What would be the output of this code:

`bar(foo)`

no. We pass in the foo method (which returns "yes") into the bar method. The param is set to "yes" and the if statement evaluates to "no"