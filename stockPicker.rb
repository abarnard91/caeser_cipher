def stockPicker(stockPriceArray)
  profitHash=Hash.new
  newProfit=0
  buyPriceSellPrice=[]
  buyDaySellDay=[]
  stockPriceArray.each_with_index do |i, indexOne|
    stockPriceArray.each_with_index do |j, indexTwo| 
      if indexTwo-indexOne>0 
        profit=j-i
        profitHash[profit]=[i,j]
      end
    end
  end
  profitHash.each do |key, value|
    if newProfit<key
      newProfit=key
      buyPriceSellPrice=value
    end
  end
  #puts buyPriceSellPrice
  buyPriceSellPrice.each do |price|
    stockPriceArray.each_with_index do |stockPrice, day|
      if price == stockPrice
        buyDaySellDay.push(day)
      end
    end
  end
  puts "#{buyDaySellDay} buy for #{buyPriceSellPrice[0]} and sell for #{buyPriceSellPrice[1]} for a profit of #{buyPriceSellPrice[1]-buyPriceSellPrice[0]}"
end

stockPicker([17,3,6,9,15,8,6,1,10])

stockPicker([1,6,9,15,8,6,12,10])

stockPicker([17,3,6,9,15,8,6,1,100])

#stockPicker([17,3,6,9])
