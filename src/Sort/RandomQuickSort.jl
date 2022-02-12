using Random
using BenchmarkTools

function RandomQuickSort(arr, i=1, j=length(arr)) # Cannot in-place?
    if i == j
        return arr
    else
        oi, oj = i, j
        len = j - i + 1
        pivot_i = rand(i:j) # Random pivot.
        swap!(arr, 1, pivot_i)
        pivot = arr[1]
        re = Vector{Int32}(undef, len) # Store the results of spliting step.
        re2 = Vector{Int32}(undef, len) # Store the results of final step.
        for ii in 2:len
            if arr[ii] > pivot
                re[j] = arr[ii]
                j -= 1
            else
                re[i] = arr[ii]
                i += 1
            end
        end
        re[div((i+j), 2)], re2[div((i+j), 2)] = pivot, pivot
        # println(re)
        arrl, arrr = (oi == i ? [] : RandomQuickSort(re[oi:(i-1)])), (j == oj ? [] : RandomQuickSort(re[(j+1):oj]))
        start_i = 1
        for jj in arrl
            re2[start_i] = jj
            start_i += 1
        end
        for kk in arrr
            start_i += 1
            re2[start_i] = kk
        end

        return re2
    end
end

function swap!(arr, i, j)
    temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
end

println(RandomQuickSort([5]))
# println(RandomQuickSort([3.4,3.344,4.68,5.00,1.12,-23]))
println(RandomQuickSort([5,6,2,3,1,6,4,1,8]))
@btime RandomQuickSort(rand(1:100, 10^5))
# println(RandomQuickSort(rand(1:100, 10^3)))