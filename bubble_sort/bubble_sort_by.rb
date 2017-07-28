def bubble_sort_by(array)
    count = 0  #establishes a count for while loop to end 
    while(count<array.length) #execute while count is less than array size
        for i in 1..array.length-1 #loop with varirable i through 1 to 4 
            if yield(array[i-1], array[i])>0 #yielding (array[0 to 3], array[1 to 4]) over course of for loop 
                array[i-1], array[i] = array[i], array[i-1] #if yielded value is greater than 0, swap these values 
            end 
        end
        count+=1 #add one to count and start while loop over again
    end
    array #return sorted values 
end

bubble_sort_by(["hi","hello","hey"]){|left, right| left.length-right.length} #=> ["hi", "hey", "hello"], block tied to yield
bubble_sort_by(["hi","hello","hey","wiggly", "appleman"]){|left, right| left.length-right.length}  #=> ["hi", "hey", "hello", "wiggly", "appleman"]
