# SkyBoxGenerator

Generate a skybox.
Script handles the necessary projections of the spherical panorama (e.g. mercator map) onto the cube.

Script should be run in the same folder as the target image.
Vectorized for the most part; will take some time for large images
(e.g. will take ~2 mins for a 4096x4096x4096 skybox on 16384x8192 panorama image)
command to run:
    
    generate_skybox('mars.png',4096)

Parameters:
filename - of image
resolution - width of resulting skybox (Game engines generally support powers of 2 up to 4096)

Original:
![Original](https://github.com/RaveCenter/SkyBoxGenerator/blob/master/example/mars.png)

After:
![Front Image](https://github.com/RaveCenter/SkyBoxGenerator/blob/master/example/front_mars.png)
![Right Image](https://github.com/RaveCenter/SkyBoxGenerator/blob/master/example/right_mars.png)
![Back Image](https://github.com/RaveCenter/SkyBoxGenerator/blob/master/example/back_mars.png)
![Left Image](https://github.com/RaveCenter/SkyBoxGenerator/blob/master/example/left_mars.png)
![Top Image](https://github.com/RaveCenter/SkyBoxGenerator/blob/master/example/top_mars.png)
![Bottom Image](https://github.com/RaveCenter/SkyBoxGenerator/blob/master/example/bottom_mars.png)


