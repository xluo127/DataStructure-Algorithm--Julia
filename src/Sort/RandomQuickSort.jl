using Random
using BenchmarkTools

function RandomQuickSort!(arr, i=1, j=length(arr)) 
    if i >= j
        return nothing
    else    
        pivot_i = partition!(arr, i, j)
        RandomQuickSort!(arr, i, (pivot_i-1))
        RandomQuickSort!(arr, (pivot_i+1), j)           

        return arr
    end
end

function partition!(arr, i=1, j=length(arr))
    pivot_i = rand(i:j) # Random pivot.
    swap!(arr, i, pivot_i)
    pivot = arr[i]    
    casei = false
    @inbounds while i != j # double while?        
        casei, i, j = caseI!(arr, casei, i, j, pivot)
    end
    arr[i] = pivot
    i
end

function caseI!(arr, casei, i, j, pivot)
    if !casei
        if arr[j] < pivot
            arr[i] = arr[j]
            i += 1
            casei = !casei
        else
            j -= 1
        end
    else
        if arr[i] >= pivot
            arr[j] = arr[i]
            j -= 1
            casei = !casei
        else
            i += 1
        end
    end
    casei, i, j
end

function swap!(arr, i::Int, j::Int)
    temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
end

println(RandomQuickSort!([5]))
# println(RandomQuickSort!([3.4,3.344,4.68,5.00,1.12,-23]))
println(RandomQuickSort!([5,6,2,3,1,6,4,1,8]))
@btime RandomQuickSort!(rand(1:100, 10^5))
# println(RandomQuickSort!(rand(1:100, 10^3)))