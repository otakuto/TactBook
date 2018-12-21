function head(xs) = xs[0];
function tail(xs) = (len(xs) > 1) ? [ for (i = [1 : len(xs) - 1]) xs[i] ] : [];
function take(n, xs) = (n > 0) ? [ for (i = [0 : n - 1]) xs[i] ] : [];
function sum(xs) = _sum(0, xs);
function _sum(z, xs) = (len(xs) > 0) ? _sum(z + head(xs), tail(xs)) : z;
