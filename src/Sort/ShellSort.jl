using Random
using BenchmarkTools

function ShellSort(arr)
    if length(arr) <= 1
        return arr
    end

    len = length(arr)
    gap = div(len, 2)
    while gap >= 1
        reminder = len % gap
        for i in 1:gap
            leni = i <= reminder ? div(len, gap) + 1 : div(len, gap)
            indice = Vector{Int}(undef, leni)
            for j in 1:leni
                indice[j] = i + gap * (j-1)
            end
            InsertionPartSort!(arr, indice)
        end
        gap = div(gap, 2)
    end

    return arr
end  

function InsertionPartSort!(arr, indice)
    if length(indice) <= 1
        return nothing
    end

    len = length(indice)
    starti = 2
    for i in starti:len
        insertValue = arr[indice[i]]
        for jr in 1:(i-1)
            j = i - jr
            if insertValue < arr[indice[j]]
                swap!(arr, indice[j+1], indice[j])                
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

println(ShellSort([]))
println(ShellSort([5]))
# println(ShellSort([3.4,3.344,4.68,5.00,1.12,-23]))
println(ShellSort([5,6,2,3,1,6,4,1,8]))
@btime ShellSort(rand(1:100, 10^5)) # 15.214 ms (100090 allocations: 19.18 MiB). Should not be that much allocations, fix later~
