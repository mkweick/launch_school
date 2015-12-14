#####1.) Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the days before computers had video screens).

For this exercise, write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:

```ruby
The Flintstones Rock!
 The Flintstones Rock!
  The Flintstones Rock!
```

```ruby
10.times { |n| puts (" " * n) + "The Flintstones Rock!" }
```

#####2.) Create a hash that expresses the frequency with which each letter occurs in this string:
```ruby
statement = "The Flintstones Rock"
```

ex:

```ruby
{ "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }
```

```ruby
result = {}
statement.gsub(' ', '').split('').uniq.each{ |l| result[l] = statement.count(l) }
```

#####3.) The result of the following statement will be an error:
```ruby
puts "the value of 40 + 2 is " + (40 + 2)
```

Why is this and what are two possible ways to fix this?

The statement is trying to merge a string and fixnum together

```ruby
puts "the value of 40 + 2 is " + (40 + 2).to_s
```

```ruby
puts "the value of 40 + 2 is #{40 + 2}"
```

#####4.) What happens when we modify an array while we are iterating over it? What would be output by this code?
```ruby
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
```

Values would get skipped. The output of this code would be:

```ruby
1
3
[3, 4]
```

What would be output by this code?

```ruby
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
```

```ruby
1
2
[1, 2]
```

#####5.) Alan wrote the following method, which was intended to show all of the factors of the input number:
```ruby
def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end
```

Alyssa noticed that this will fail if you call this with an input of 0 or a negative number and asked Alan to change the loop. How can you change the loop construct (instead of using begin/end/until) to make this work? Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.

Change the loop to a while loop, see below:

```ruby
def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end
```

Bonus 1

What is the purpose of the number % dividend == 0 ?

Check to make sure there is no remainder, goes in evenly

Bonus 2

What is the purpose of the second-to-last line in the method (the divisors before the method's end)?

return the divisors array. Last line in ruby method will return.

#####6.) Alyssa was asked to write an implementation of a rolling buffer. Elements are added to the rolling buffer and if the buffer becomes full, then new elements that are added will displace the oldest elements in the buffer.

She wrote two implementations saying, "Take your pick. Do you like << or + for modifying the buffer?". Is there a difference between the two, other than what operator she chose to use to add an element to the buffer?

```ruby
def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end
```

```ruby
def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end
```

`rolling_buffer1` will modify the buffer passed into it. `rolling_buffer2` will return an updated buffer array but the original buffer passed into will not be modified. I would use `rolling_buffer1` to ensure the original buffer is always current and up to date.

#####7.) Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator, A user passes in two numbers, and the calculator will keep computing the sequence until some limit is reached.

Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code?

```ruby
limit = 15

def fib(first_num, second_num)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"
```

How would you fix this so that it works?

You could pass the limit variable into the `def fib` method as third arg or make limit a constant `LIMIT = 15`

#####8.) In another example we used some built-in string methods to change the case of a string. A notably missing method is something provided in Rails, but not in Ruby itself...titleize! This method in Ruby on Rails creates a string that has each word capitalized as it would be in a title.

Write your own version of the rails titleize implementation.

```ruby
def titleize(string)
  string.split(' ').map{ |word| word.capitalize }.join(' ')
end
```

#####9.) Given the munsters hash below
```ruby
munsters = { 
  "Herman" => { "age" => 32, "gender" => "male" }, 
  "Lily" => { "age" => 30, "gender" => "female" }, 
  "Grandpa" => { "age" => 402, "gender" => "male" }, 
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
```

Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). Your solution should produce the hash below

```ruby
{ "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
  "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
  "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
  "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
  "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }
```

Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

```ruby
munsters.each do |k, values|
  case values["age"]
  when 0..17 then values["age_group"] = "kid"
  when 18..64 then values["age_group"] = "adult"
  else values["age_group"] = "senior"
  end
end
```