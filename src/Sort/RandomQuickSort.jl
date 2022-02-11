using Random
using BenchmarkTools

function RandomQuickSort!(arr, i=1, j=length(arr)) # Cannot in-place?
    if i == j
        return nothing
    else
        len = j - i + 1

    end
end