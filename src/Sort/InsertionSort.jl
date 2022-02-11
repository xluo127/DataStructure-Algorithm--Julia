using Random
using BenchmarkTools

function InsertionSort(arr)
    if length(arr) <= 1
        return arr
    end

    len = length(arr)
    starti = 2
    for i in starti:len
        insertValue = arr[i]
        for jr in 1:(i-1)
            j = i - jr
            if insertValue < arr[j]
                swap!(arr, j+1, j)                
            else
                break
            end
        end
    end

    return arr
end

function swap!(arr, i, j)
    temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
end

println(InsertionSort([]))
println(InsertionSort([5]))
println(InsertionSort([3.4,3.344,4.68,5.00,1.12,-23]))
@btime InsertionSort(rand(1:100, 10^5)) # 2.894 s (2 allocations: 781.30 KiB). If more data, it can take very long to return the result.
