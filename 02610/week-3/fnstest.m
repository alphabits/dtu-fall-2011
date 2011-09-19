function res = fnstest(x)
    function d = inner()
        innervar = 4;
        function e = innerinner()
            e = x*innervar;
        end
        d = innerinner();
    end

    res = inner();
end
