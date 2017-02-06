function [ edges ] = tracePath(size, orig, vel1, vel2)
    if nargin == 4
        edge1 = tracePath(size, orig, vel1);
        edge2 = tracePath(size, orig, vel2);
        if ~numel(edge1)
            edges = edge2;
        elseif ~numel(edge2)
            edges = edge1;
        else
            if edge1.side == edge2.side
                edges.side = edge1.side;
                edges.p = [edge1.p;edge2.p];
                edges.t = [edge1.t;edge2.t];
            elseif edge1.side == 't'
                edges = edge1;
                if edge2.side == 'b'
                    t = (size(1)*(vel1(1) > 0) - orig(1)) / vel1(1);
                    edges(2) = edge2;
                    edges(3).p = [0 size(2)];

                    if vel1(1) > 0
                        edges(1).p(2) = size(1);
                        edges(2).p(2) = size(1);
                        edges(1).t(2) = t;
                        edges(2).t(2) = t;
                        edges(3).side = 'r';
                        edges(3).t = [t t];
                    elseif vel(1) < 0
                        edges(1).p(2) = 0;
                        edges(2).p(2) = 0;
                        edges(3).side = 'r';
                        edges(1).t(2) = t;
                        edges(2).t(2) = t;
                        edges(3).t = [t t];
                    end
                else
                    edges(2) = edge2;
                    edges(1).p(2) = size(1)*(vel1(1) > 0);
                    edges(1).t(2) = edge2.t;
                    edges(2).p(2) = size(2);
                    edges(2).t(2) = edge2.t;
                end
            else
                edges = edge1;
                edges.p(2) = 0;
                edges.t(2) = edge1.t;
                edges(2) = edge2;
                edges(2).p(2) = size(1)*(vel1(1) > 0);
                edges(2).t(2) = edge1.t;
            end
        end

    else
        left = (size.*(vel1 > 0) - orig) ./ vel1;

        if left(1) < left(2)
            if vel1(1) > 0
                edges.side = 'r';
            else
                edges.side = 'l';
            end
            edges.p = orig(2) + left(1)*vel1(2);
            edges.t = left(1);
        elseif left(1) > left(2)
            if vel1(2) > 0
                edges.side = 't';
            else
                edges.side = 'b';
            end
            edges.p = orig(1) + left(2)*vel1(1);
            edges.t = left(2);
        else
            edges = [];
        end
    end
end

