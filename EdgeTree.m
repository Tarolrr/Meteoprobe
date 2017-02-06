classdef EdgeTree < handle
    properties
        coords = [];
        left = [];
        right = [];
        top = [];
        bottom = [];
        parent = [];
    end
    methods
        function obj = EdgeTree(parent)
            obj.parent = parent;
        end
    end
end