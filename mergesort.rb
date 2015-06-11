#not in-place merge sort in ruby

def partition (l, a, b)
    size = l.length / 2
    for i in 0..l.length-1
        if i < size
            a.push(l[i])
        else
            b.push(l[i])
        end
    end
end

def merge(a, b)
    indexA = 0
    indexB = 0

    l = Array.new

    while (indexA != a.length || indexB != b.length)
        if (indexA == a.length)
            l.push(b[indexB])
            indexB += 1
        elsif (indexB == b.length)
            l.push(a[indexA])
            indexA += 1
        else
            if (a[indexA] <= b[indexB])
                l.push(a[indexA])
                indexA += 1
            elsif (b[indexB] <= a[indexA])
                l.push(b[indexB])
                indexB += 1
            end
        end
    end
    return l
end

def mergesort (thelist)
    if (thelist.length == 1)
        return thelist
    end
    a = Array.new
    b = Array.new
    partition(thelist, a, b)
    a = mergesort(a)
    b = mergesort(b)
    thelist = merge(a, b)
    return thelist
end


l = [2, 3, 5, 7, 1, 0]

mergesort(l).each { |x| print x , ' ' }
