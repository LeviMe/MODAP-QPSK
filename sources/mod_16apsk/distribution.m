
%Source: openExample('matlab/CountOfUniqueElementsExample')
% mathworks.com/help/matlab/ref/unique.html#mw_42eea7c7-dde5-45e9-8434-133a1dfe4b6a

%M est un vecteur d'objets ou un élément donné étant situé sur une même
%ligne (row)
%C est un ensemble: les éléments uniques de M.
% proportions est un vecteur donnant la proportion d'apparition de chacun
% dans M

function [C, proportions]=distribution(M)
    [C,ia,ic] = unique(M,'rows');
    a_counts = accumarray(ic,1);
    %statistiques = [C, a_counts];
    proportions  =   (a_counts/sum(a_counts));
end
