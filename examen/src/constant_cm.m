function R=constant_cm(n,p)
    R=p*ones(n);
    for i=1:n
        R(i,i)=1;
    end
end