dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(theString, theArray)
  wordHash=Hash.new
  theString=theString.downcase
  string_array=theString.split
  puts "#{string_array}"
  string_array.each do |element| 
    theArray.each do |i| 
      if element.include?(i)
        if wordHash.keys.include?(i)
          wordHash[i]+=1
        end
        if wordHash.keys.include?(i)!=true
          wordHash[i]=1
        end     
      end    
    end
  end
  puts "#{wordHash}"
end

substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?",dictionary)
