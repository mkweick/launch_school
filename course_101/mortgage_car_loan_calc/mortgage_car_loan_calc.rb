def prompt(msg)
  puts "==>  #{msg}"
end

def valid_loan_amount?(loan, loan_type)
  if loan_type == 'Mortgage'
    loan.to_i.to_s == loan && loan.to_i >= 20_000
  else
    loan.to_i.to_s == loan && loan.to_i >= 5_000
  end
end

def print_invalid_loan_msg(loan_type)
  if loan_type == '1'
    prompt "Mortgage must be greater than $19,999 and no decimals:"
  else
    prompt "Car loan must be greater than $4,999 and no decimals:"
  end
end

prompt "Welcome to the Mortgage / Car Loan Calculator"
prompt "Whats your name?"

name = gets.chomp.capitalize
until name =~ /\A^[a-zA-Z]+$\z/
  prompt "Name can't be blank and must only contain letters:"
  name = gets.chomp.capitalize
end

prompt "Great! Let's get started #{name}!"

loop do
  prompt <<-MSG
Are you calculating a Mortgage or Car Loan?
      1.) Mortage
      2.) Car Loan
  MSG
  loan_type = gets.chomp
  until %w(1 2).include? loan_type
    prompt "Please choose '1' for Mortage or '2' for Car Loan:"
    loan_type = gets.chomp
  end
  loan_type_name = (loan_type == '1' ? 'Mortgage' : 'Car Loan')

  prompt(loan_type == '1' ? "Mortgage amount?" : "Car loan amount?")
  loan_amount = gets.chomp
  until valid_loan_amount?(loan_amount, loan_type_name)
    print_invalid_loan_msg(loan_type)
    loan_amount = gets.chomp
  end

  prompt "Interest Rate? (Ex. 5 for 5% or 2.5 for 2.5%)"
  interest_rate = gets.chomp
  until interest_rate.to_f > 0
    prompt "Interest Rate must be greater than zero:"
    interest_rate = gets.chomp
  end

  prompt "Loan duration? (in years)"
  years = gets.chomp
  until years.to_i.to_s == years && years.to_i > 0
    prompt "Enter a valid number:"
    years = gets.chomp
  end

  annual_interest_rate = interest_rate.to_f / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = years.to_i * 12
  monthly_payment = loan_amount.to_f *
                    (monthly_interest_rate /
                    (1 - (1 + monthly_interest_rate)**-months.to_i))
  prompt "Your monthly payment is: $#{format('%02.2f', monthly_payment)}"

  prompt "Would you like to make another calculation? 'Y' or 'N'"
  calc_again = gets.chomp.upcase
  until %w(Y N).include? calc_again
    prompt "Please type 'Y' to calculate again or 'N' to quit:"
    calc_again = gets.chomp.upcase
  end

  break if calc_again == 'N'
end

prompt "Thanks for using the Mortgage / Car Loan Calculator. Goodbye #{name}!"
