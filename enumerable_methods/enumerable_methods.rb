module Enumerable

  #Create #my_each, a method that is identical to #each but (obviously) 
  #does not use #each. You'll need to remember the yield statement. 
  #Make sure it returns the same thing as #each as well.
  def my_each
	    if block_given?
    	    i = 0
    		  while(i<self.length)
    		      yield(self[i])  #when other methods call .my_each on self, a block is being passed to the .my_each method
    		      i+=1
    		  end
    		  self
  	  else
  	      self.to_enum
  	  end 
	end 

  #Create #my_each_with_index in the same way.
	def my_each_with_index
	    if block_given?
  		    i = 0
  		    while(i<self.length)
  			      yield(self[i], i)  #yields value, index into potential block 
  			      i+=1
  		    end
  		    self
  	  else
  	      self.to_enum
  	  end 
	end

  #Create #my_select in the same way, though you may use #my_each in 
  #your definition (but not #each).
	def my_select
	    if block_given?
  	      selected = []
  	          self.my_each do |x|  #uses my_each to loop through each index of array 
  	              if yield(x) 
  	                  selected.push(x)  #add value to 'selected' array
  	              end
  	          end
  	      selected
  	  else 
  	      self.to_enum
  	  end 
	end

  #Create #my_all? (continue as above)
	def my_all?
	    if block_given?
	        self.my_each do |x|
	            if yield(x) == false  #if any value is false, return false
	                return false
	            end 
	        end 
	        true  #if no values are false, all values are true, return true 
	    else 
	        if (self.my_any?{|value|value == nil || value == false}) == true 
	            return false
	        else self.my_all? {|x|x}
	        end 
	    end 
	end

  #Create #my_any?
	def my_any?
	    if block_given?
  		    self.my_each do |x|
  		        if yield(x)  #if any of values yields true, return true  
  		  	        return true 
  		        end
  		    end
  		    false  #if none return true, result is false 
	    else
	        if (self.my_all? {|value| value==false || value==nil})  #if there is no block and all values are either false or nil:
	            return false 
	        else  #if there is no block and at least one value is not either false or nil: 
	            return true 
	        end 
	    end 
	end 

  #Create #my_none?
	def my_none?
	    if block_given?
  		    self.my_each do |x|
  		        if yield(x) == true  #if any value is true, return false
  		  	        return false 
  		        end 
  		    end 
  		    true  #if none of the values are true, return true 
	    else 
	        false
	    end 
	end 

  #Create #my_count
	def my_count(param = nil)  #allows for no parameter to be given 
	    count = 0  #count value established 
      self.my_each do |x|
          if block_given?
          	  if param  #if param is given it will override the block:
          	      if param == x  #if param is equal to current iterated value:
                      count += 1  
                  end 
              else 
                  if yield(x) == true  #if param is not given but block is, if yielded value is equal to true:
                      count += 1  
                  end
              end 
          elsif param == nil  #if block is not given and param is not given:
              count += 1
          else
              if param == x  #if block is not given and param is equal to x:
                  count += 1
              end
          end 
      end
	    count
	end 

  #Create #my_map
	def my_map
	    if block_given?
	        array = []
	        self.my_each do |x|
	            array << yield(x)  #yielded value is added it to array (after yield modification)
	        end 
	    array  #return the array 
	    else 
	        self.to_enum
	    end 
	end

  #Modify your #my_map method to take either a proc or a block. It won't
  #be necessary to apply both a proc and a block in the same #my_map 
  #call since you could get the same effect by chaining together one 
  #my_map call with the block and one with the proc. This approach is 
  #also clearer, since the user doesn't have to remember whether the 
  #proc or block will be run first. So if both a proc and a block are 
  #given, only execute the proc.
	def my_map_proc(&multiply_shit)  #proc 'multiply_shit' is potential parameter for method 
	    if block_given?
	        array = []
	        self.my_each do |x|
	            array << multiply_shit.call(x)  #proc is called on value and added to array 
	        end 
	        array  #return array 
	    else 
	        self.to_enum
	    end 
	end

  #Create #my_inject

	def my_inject(total=nil)  #allows for initial total value to be input  
	    if total == nil  #if there is no given total value: 
	        total = self[0]  #total starts as first value of array 
	        self[1..self.length-1].my_each do |x|  #my_each is run on self[1 to the_last_index_of_self]
	            total = yield(total, x)  #two paramters are given to be substitued into yield block given, equaling total 
	        end
	    else  #there is a total initial value given:  
	        self.my_each do |x|  #the full array is iterated through from self[0 to the_last_index_of_self]
	            total = yield(total, x)  
	        end 
	    end
	    total  #output total 
	end 


end 

#Test your #my_inject by creating a method called #multiply_els which 
#multiplies all the elements of the array together by using #my_inject, 
#e.g. multiply_els([2,4,5]) #=> 40
def multiply_els(arr)
    arr.my_inject{|total, x| total * x}
end 

multiply_els([2,4,5]) #=> 40


[1,2,2,2,3,4,6].my_each{|var| print "#{var} "}  #=> [1, 2, 2, 2, 3, 4, 6]
[1,2,2,2,3,4,6].my_each_with_index{|var,idx| print "index #{idx} holds value #{var}. "}  #index 0 holds value 1. index 1 holds value 2. index 2 holds value 2. index 3 holds value 2. index 4 holds value 3. index 5 holds value 4. index 6 holds value 6.                                                                                 
[4,"fart",2,"numba"].my_select {|var| var != "fart"}  #=> [4, 2, "numba"]
["same", "same", "same"].my_all? {|var| var == "same"}  #=> true
["same", "same", "different"].my_all? {|var| var == "same"}  #=> false 
[1,2,2,2,3,4,6].my_any? {|var| var>3}  #=> true 
[1,2,2,2,3,4,6].my_any? {|var| var>7}  #=> false 
[1,2,2,2,3,4,6].my_none? {|var| var>7}  #=> true 
[1,2,2,2,3,4,6].my_none? {|var| var>3}  #=> false  
["fart", "item", "dog", "dog"].my_count {|value| value == "big"}
[1,2,2,2,3,4,6].my_count {|value| value%2 == 0}  #=> 5
[1,2,2,2,3,4,6].my_count(2) {|value| value%2 == 0}  #=> 3
[1,2,2,2,3,4,6].my_count  #=> 7 
[1,2,2,2,3,4,6].my_map {|var| var*2}  #=> [2, 4, 4, 4, 6, 8, 12]

multiply_shit = Proc.new {|value| value*3}
[1,2,2,2,3,4,6].my_map_proc(&multiply_shit)  #=> [3, 6, 6, 6, 9, 12, 18]

[1,2,2,2,3,4,6].my_inject{|total, x| total + x}  #=> 20
[1,2,2,2,3,4,6].my_inject(2){|total, x| total * x}  #=> 22

