require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(msg)
  puts "=> #{msg}"
end

def operation_to_msg(operator)
  case operator
  when "+" then MESSAGES['add_msg']
  when "-" then MESSAGES['subtract_msg']
  when "*" then MESSAGES['multiply_msg']
  when "/" then MESSAGES['divide_msg']
  end
end

prompt MESSAGES['welcome']
name = gets.chomp.capitalize
prompt "Hi #{name}!"

loop do
  prompt MESSAGES['first_number']
  num1 = gets.chomp
  until num1 =~ /\A\d+\.?\d*\z/
    prompt MESSAGES['invalid_number']
    num1 = gets.chomp
  end

  prompt MESSAGES['second_number']
  num2 = gets.chomp
  until num2 =~ /\A\d+\.?\d*\z/
    prompt MESSAGES['invalid_number']
    num2 = gets.chomp
  end

  prompt MESSAGES['operation']
  operator = gets.chomp
  until %w(+ - * /).include? operator
    prompt MESSAGES['invalid_operation']
    operator = gets.chomp
  end

  result =  case operator
            when "+" then (num1.to_f + num2.to_f).round(2)
            when "-" then (num1.to_f - num2.to_f).round(2)
            when "*" then (num1.to_f * num2.to_f).round(2)
            when "/" then (num1.to_f / num2.to_f).round(2)
            end

  prompt "#{operation_to_msg(operator)} the two numbers..."
  sleep 2
  prompt "The result is: #{result}"

  prompt MESSAGES['calc_again']
  calc_again = gets.chomp.upcase
  until %w(Y N).include? calc_again
    prompt MESSAGES['invalid_calc_again']
    calc_again = gets.chomp.upcase
  end

  break if calc_again == 'N'
end

prompt "Thanks for using Calculator. Good bye #{name}!"
