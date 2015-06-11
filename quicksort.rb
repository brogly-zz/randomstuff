#not in-place quicksort in ruby

def partition (lst, l, e, g)
    #pivot selection is generally random
    pivot = lst.last
    for i in 0..lst.length-1
        if (lst[i] < pivot)
            l.push(lst[i])
        elsif (lst[i] == pivot)
            e.push(lst[i])
        else
            g.push(lst[i])
        end
    end
end

def qsort(lst)
    if (lst.length == 0 || lst.length == 1)
        return lst
    end

    l = Array.new
    e = Array.new
    g = Array.new

    partition(lst, l, e, g)

    l = qsort(l)
    e = qsort(e)
    g = qsort(g)

    l.concat(e)
    l.concat(g)
    return l
end

puts qsort([5,2,3,1,0,9,4])
