pkg load statistics

vet1 = [1 1 2 1 1 1 2 1 1 1 1 1];
vet2 = [4 5 6 7 8 9 10 11 12 13];

axis ([0, 3]);
boxplot ({boxdata(1,:), boxdata(2,:), boxdata(3,:)});
%set (gca (), "xtick", [1 2], "xticklabel", {"girls", "boys"})
title ("Grade 3 heights");
