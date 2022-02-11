using Random
using BenchmarkTools

function MergeSort(arr)
    if length(arr) <= 1
        return arr
    end

    len = length(arr)
    leni = div(len, 2)
    re = leni >= 1 ? Merge(MergeSort(arr[1:leni]), MergeSort(arr[(leni+1):len])) : arr

    return re
end

function Merge(arrl, arrr)
    i, j, k = 1, 1, 1
    lenl, lenr = length(arrl), length(arrr)
    len = lenl + lenr
    # Set to work for Integers only. 
    arr = Vector{Int32}(undef, len)
    while k <= len
        if j > lenr
            arr[k] = arrl[i]
            i += 1
        elseif i > lenl || arrl[i] > arrr[j]
            arr[k] = arrr[j]
            j += 1
        else
            arr[k] = arrl[i]
            i += 1
        end
        k += 1
    end

    return arr
end

println(MergeSort([]))
println(MergeSort([5]))
# println(MergeSort([3.4,3.344,4.68,5.00,1.12,-23]))
println(MergeSort([5,6,2,3,1,6,4,1,8]))
@btime MergeSort(rand(1:100, 10^5)) # 18.307 ms (300092 allocations: 36.98 MiB)