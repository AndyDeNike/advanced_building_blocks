def bubble_sort(array)
    count = 0 #establishes a count for while loop to end 
  
    while(count<array.length) #execute while count is less than array size
        for i in 1..array.length-1 #loop with varirable i through 1 to 4 
            if array[i-1]>array[i] #yielding (array[0 to 3], array[1 to 4]) over course of for loop 
                array[i-1], array[i] = array[i], array[i-1] #if yielded value is greater than 0, swap these values 
            end 
        end
    count+=1 #add one to count and start while loop over again
    end
    array #return sorted values 
end

bubble_sort([4,3,78,2,0,2]) #=> [0, 2, 2, 3, 4, 78]