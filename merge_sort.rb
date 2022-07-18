require 'pry'

def merge_sort(array, merged_array = [])
  # base case
  if array.length == 1
    return array
  end
  # split array into 2
  # if odd number of elements then round up for the first split array
  if array.length % 2 != 0 
    half = (array.length / 2).ceil + 1
    array1 = array.slice(0, half)
    array2 = array.slice(half, array.length)
  else
    half = array.length / 2
    array1 = array.slice(0, half)
    array2 = array.slice(half, array.length)
  end

    # if the array size is more than 1 then split again
    if array1.length > 1
      array1 = merge_sort(array1)
      array2 = merge_sort(array2)
    end

    # sort the splitted array into the merged array
    first = array1.length
    second = array2.length
    counter1 = 0
    counter2 = 0
    while (counter1 + counter2) < (first + second)
      if counter1 == first
        merged_array.insert((counter1 + counter2), array2[counter2])
        counter2 += 1 
      elsif
        counter2 == second
        merged_array.insert((counter1 + counter2), array1[counter1])
        counter1 += 1
      else
        if array1[counter1] > array2[counter2]
          merged_array.insert((counter1 + counter2), array2[counter2])
          counter2 += 1
        else
          merged_array.insert((counter1 + counter2), array1[counter1])
          counter1 += 1
        end
      end
    end
    merged_array
end

p merge_sort([10,6,3,7,2,4,9,2000,99])