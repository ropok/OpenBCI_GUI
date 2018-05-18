function normalized = normalize_var(array, x, y)
    
    % Normalize to [0, 1]
    m = min(array(:));
    range = max(array(:)) - m;
    array = (array - m) / range;

    % Then scale to [x, y]:
    range2 = y - x;
    normalized = (array*range2) + x;
end

% % 4. Normalisasi Data
% for i=1:4
% 	pN = gabPutih(:,i) - min(gabPutih(:,i));
% 	pN = pN ./ max(pN(:));
% 	gabPutih(:,i) = pN;

% 	mN = gabMerah(:,i) - min(gabMerah(:,i));
% 	mN = mN ./ max(mN(:));
% 	gabMerah(:,i) = mN;

% 	bN = gabBiru(:,i) - min(gabBiru(:,i));
% 	bN = bN ./ max(bN(:));
% 	gabBiru(:,i) = bN;
% end