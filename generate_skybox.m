

function generate_skybox(filename, resolution)

image = imread(filename);
%%%



s = 1/sqrt(3);

% rectangle bounds, TL, TR, BL, BR (x,y,z)
% x = s for front dir (theta and phi = 0)
% bounds = [y1 z1; y2 z2; ...]
% front_bounds = [1,1; -1,1; 1,-1; -1,-1]*s;

indices_X = ones(resolution)*s;
indices_Y = repmat(linspace(s, -s, resolution), [resolution 1]);
indices_Z = repmat(linspace(s, -s, resolution)', [1 resolution]);

magnitude = sqrt(indices_Y.*indices_Y + indices_Z.*indices_Z + s*s);

% normalize vectors, get x y z coords of 'ray-traced' to unit sphere
indices_X = indices_X./magnitude;
indices_Y = indices_Y./magnitude;
indices_Z = indices_Z./magnitude;

% convert to polar coordinates
% rho = 1
phi = acos(indices_Z);
%r = sin(phi);
%theta = asin(indices_Y./r);
theta = atan2(indices_Y, indices_X);

% iterate across each rectangle

% save rectangle's data

image_front = get_image_from_coords(image, theta, 0, phi);
imwrite(image_front,['front_' filename]);
clear image_front;

image_right = get_image_from_coords(image, theta, pi/2, phi);
imwrite(image_right,['right_' filename]);
clear image_right;

image_left = get_image_from_coords(image, theta, -pi/2, phi);
imwrite(image_left,['left_' filename]);
clear image_left;

image_back = get_image_from_coords(image, theta, pi, phi);
imwrite(image_back,['back_' filename]);
clear image_back;




indices_Y = repmat(linspace(s, -s, resolution), [resolution 1]);
indices_X = repmat(linspace(-s, s, resolution)', [1 resolution]);
indices_Z = ones(resolution)*s;
% normalize vectors, get x y z coords of 'ray-traced' to unit sphere
magnitude = sqrt(indices_Y.*indices_Y + indices_X.*indices_X + s*s);
indices_X = indices_X./magnitude;
indices_Y = indices_Y./magnitude;
indices_Z = indices_Z./magnitude;
% convert to polar coordinates
phi = acos(indices_Z);
theta = atan2(indices_Y, indices_X);%asin(indices_Y./r);

image_top = get_image_from_coords(image, theta, 0, phi);
imwrite(image_top,['top_' filename]);
clear image_top;


indices_Y = repmat(linspace(s, -s, resolution), [resolution 1]);
indices_X = repmat(linspace(s, -s, resolution)', [1 resolution]);
indices_Z = ones(resolution)*-s;
% normalize vectors, get x y z coords of 'ray-traced' to unit sphere
magnitude = sqrt(indices_Y.*indices_Y + indices_X.*indices_X + s*s);
indices_X = indices_X./magnitude;
indices_Y = indices_Y./magnitude;
indices_Z = indices_Z./magnitude;
% convert to polar coordinates
phi = acos(indices_Z);
theta = atan2(indices_Y, indices_X);%asin(indices_Y./r);



image_bottom = get_image_from_coords(image, theta, 0, phi);
imwrite(image_bottom,['bottom_' filename]);
clear image_bottom;
end


function projection = get_image_from_coords(image, theta, dtheta, phi)

resolution = length(theta);
ntheta = theta + dtheta;
ntheta(ntheta < 0) = ntheta(ntheta < 0) + 2*pi;

nphi = phi;
nphi(nphi < 0) = nphi(nphi < 0) + 2*pi;
%if(dphi < 0)
%    nphi(resolution/2+1:end,:) = rot90(rot90(nphi(1:resolution/2,:)));
%elseif(dphi > 0)
%    nphi(1:resolution/2,:) = rot90(rot90(nphi(resolution/2+1:end,:)));
%end

[height, width, depth] = size(image);

image_i = round(height*nphi/pi);
image_j = round(width*(1-ntheta/(2*pi)));

% just in case bounds are exceeded, +1 because last column available
image_i = mod(image_i-1,height)+1;
image_j = mod(image_j-1,width)+1;

projection = zeros(resolution, resolution, depth);
for i = 1:resolution
    for j = 1:resolution
        %image_i(i,j), image_j(i,j)
        %image(image_i(i,j), image_j(i,j),:)
        projection(i,j,:) = image(image_i(i,j), image_j(i,j),:);
        %projection(i,j,:)
    end
end
projection = uint8(projection);
end