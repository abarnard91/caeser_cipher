
def string_to_number(the_string, shift_value)
  alphabet ="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ. ,?\'!"
  symbols= [ " " , "." , "!" , "?" , ",","\'" ]
  alphabet_array=alphabet.split('')
  numerical_array=[]
  code_array=[]
  i=0
  string_in_array=the_string.split('')
  string_in_array.each_with_index do |i, index| 
    alphabet_array.each_with_index do |letter, index_two|
      if letter == i
        if index_two<= 51   
          index_two += shift_value
          if ((index_two- shift_value) <=25 && index_two > 25)|| ((index_two-shift_value>25)&& index_two>51)
            index_two-=26
            #puts "index_two is #{index_two}"
          end
        numerical_array << index_two 
        end
        if index_two>51
          numerical_array << index_two
        end
      end
    end
    
  end
  numerical_array.each do |number | 
    alphabet_array.each_with_index do |new_letter, index_three|
      if number == index_three 
        code_array << new_letter
      end
    end
  end
  code_word=code_array.join('')
  puts the_string
  #puts alphabet_array.length
  #alphabet_array.fetch(58, "Theres only 57 spots goof")
  #puts alphabet_array[25], alphabet_array [51]
  #puts "#{numerical_array}"
  puts code_word
  
end
puts "What do you want encrypted"
user_string=gets.chomp
puts "What\'s your shift?"
user_shift_value=gets.chomp
string_to_number(user_string, user_shift_value.to_i)
