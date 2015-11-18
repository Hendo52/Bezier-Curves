// N Degree Bezier Curve Test
// I should make cubes that display their x, y and z coods on each face
module bezier (ControlMatrix,order,showcontrols,size, res, ps, pr, p0a, pna, red,green,blue)
{
function a1             (t)       = (1-t)*CM[0]+t*CM[1];
function a2             (t)       = (1-t)*CM[1]+t*CM[2];
function a3             (t)       = (1-t)*CM[2]+t*CM[3];
function b1             (t)       = (1-t)*a1(t)+t*a2(t);
function b2             (t)       = (1-t)*a2(t)+t*a3(t);
function curve          (t)       = (1-t)*b1(t)+t*b2(t); 

function fac            (f)       = (f==0?1:fac(f-1)*f);  
function comb           (n,k)     = (fac(n))/(fac(k)*(fac(n-k)));    
function order          (CM)      = (len(CM)-1);                         
function profilecoords  ()        = [for(i=[0:1:ps-1])[pr*(cos(360/ps*i)), pr*(sin(360/ps*i)),0]];
function profilefaces   ()        = [for(i=[0:1:ps-1])[0,i,i+1]];
function phcoords       ()        = [for(i=[1:1:ps-1],j=[0:1/res:1]) profilecoords()[i]+curve(j)];
    

function encoding1      (j)        = [for(i=[0:1:res-2]) [i,i+1,i+res]+[j,j,j]];
function encoding2      ()         = [for(j=[0:res:((res)*ps)])  encoding1(j)];


echo(encoding2());  
echo(ps, "sides"); 
echo(res, "divisons"); 


//polyhedron(points=[for (i=[0:1:res])phcoords ()[i]], faces =[for (j=[0:1:res])encoding2()[0][j]],     convexity = 1 );   


// This is the same as the echo except with the excess brackets taken out. I cant seem to get the concat function working.
polyhedron(points=phcoords (), faces =   

[[0, 1, 20], [1, 2, 21], [2, 3, 22], [3, 4, 23], [4, 5, 24], [5, 6, 25], [6, 7, 26], [7, 8, 27], [8, 9, 28], [9, 10, 29], [10, 11, 30], [11, 12, 31], [12, 13, 32], [13, 14, 33], [14, 15, 34], [15, 16, 35], [16, 17, 36], [17, 18, 37], [18, 19, 38],
 [20, 21, 40], [21, 22, 41], [22, 23, 42], [23, 24, 43], [24, 25, 44], [25, 26, 45], [26, 27, 46], [27, 28, 47], [28, 29, 48], [29, 30, 49], [30, 31, 50], [31, 32, 51], [32, 33, 52], [33, 34, 53], [34, 35, 54], [35, 36, 55], [36, 37, 56], [37, 38, 57], [38, 39, 58],
 [40, 41, 60], [41, 42, 61], [42, 43, 62], [43, 44, 63], [44, 45, 64], [45, 46, 65], [46, 47, 66], [47, 48, 67], [48, 49, 68], [49, 50, 69], [50, 51, 70], [51, 52, 71], [52, 53, 72], [53, 54, 73], [54, 55, 74], [55, 56, 75], [56, 57, 76], [57, 58, 77], [58, 59, 78],
 [60, 61, 80], [61, 62, 81], [62, 63, 82], [63, 64, 83], [64, 65, 84], [65, 66, 85], [66, 67, 86], [67, 68, 87], [68, 69, 88], [69, 70, 89], [70, 71, 90], [71, 72, 91], [72, 73, 92], [73, 74, 93], [74, 75, 94], [75, 76, 95], [76, 77, 96], [77, 78, 97], [78, 79, 98],
 [80, 81, 100], [81, 82, 101], [82, 83, 102], [83, 84, 103], [84, 85, 104], [85, 86, 105], [86, 87, 106], [87, 88, 107], [88, 89, 108], [89, 90, 109], [90, 91, 110], [91, 92, 111], [92, 93, 112], [93, 94, 113], [94, 95, 114], [95, 96, 115], [96, 97, 116], [97, 98, 117], [98, 99, 118],
 [100, 101, 120], [101, 102, 121], [102, 103, 122], [103, 104, 123], [104, 105, 124], [105, 106, 125], [106, 107, 126], [107, 108, 127], [108, 109, 128], [109, 110, 129], [110, 111, 130], [111, 112, 131], [112, 113, 132], [113, 114, 133], [114, 115, 134], [115, 116, 135], [116, 117, 136], [117, 118, 137], [118, 119, 138],
 [120, 121, 140], [121, 122, 141], [122, 123, 142], [123, 124, 143], [124, 125, 144], [125, 126, 145], [126, 127, 146], [127, 128, 147], [128, 129, 148], [129, 130, 149], [130, 131, 150], [131, 132, 151], [132, 133, 152], [133, 134, 153], [134, 135, 154], [135, 136, 155], [136, 137, 156], [137, 138, 157], [138, 139, 158],
 [140, 141, 160], [141, 142, 161], [142, 143, 162], [143, 144, 163], [144, 145, 164], [145, 146, 165], [146, 147, 166], [147, 148, 167], [148, 149, 168], [149, 150, 169], [150, 151, 170], [151, 152, 171], [152, 153, 172], [153, 154, 173], [154, 155, 174], [155, 156, 175], [156, 157, 176], [157, 158, 177], [158, 159, 178],

], convexity = 1 );


translate (phcoords()[0])sphere(3);




  
module profile1 (ps,pr,p0a,pna)  {   for(j=[0:1:(ps-2) ]) color([j/ps,j/ps,0])
polyhedron(points = [ for(i=[0:1:(ps-1)]) profilecoords()[i]],faces = [ for(i=[0:1:(ps-2)]) profilefaces()[i]],convexity=1);  
    
    
/*profileS*/ /* for (i=[0:1:ps-1])translate(profilecoords()[i]) color([i/ps,i/ps,i/ps]) sphere(1.5,$fn=30); */}  
            
/*Curve   */  for (t = [0:1/res:1]) {translate(curve(t))color([red,green,blue])profile1 (ps,pr);}

/*Controls*/  if  (controls ==true){ for (i=[0.01:1:order]) {
/*Points  */  translate (CM[i])color([(i/order)*red,(i/order)*green,(i/order)*blue])sphere(size,$fn =30);
/*Bars    */  for (i=[0:order-3]) { color([red/2,green/2,blue/2])           
            hull(){translate(CM[i]) sphere(size/3, $fn =30);translate (CM[i+1])sphere (size/3,$fn =30); 
            };}}}else{echo("Control points are off"); }}   
    
bezier(CM = [([  0,    0,   00 ]),
             ([ -40,   40,   60 ]),
             ([  40,  100,   80 ]), 
             ([   0,    0,  200 ]),
             ([  50,   50,  275 ])], order=5, controls=true, size=2.5,  res=20, ps=10, pr=8,
        p0a = [   0,    0,    0 ],
        pna = [   0,    0,   90 ],   red = 0.4, green = 0, blue = 0.4 );




/*    
// https://youtu.be/qhQrRCJ-mVg?t=5m44s
    
echo("Bmatrix =");
for (i = [0 : 1 : order-1]) {  echo(bernmatrix(1,1)[i] ); };
    
*/  
    
//multmatrix(m= [ rotate ([0,0,90]) CM[0] and CM[order]





    //create a function that works out the values the spheres are at in matrix form
    // this may require mult matrix, an understanding of v in rotate and cross products.
    // echo(cross([2, 3, 4], [5, 6, 7]));  
    // create a function that lists the order of the faces i.e. 1,2,3  1,3,4  1,4,5  1,5,6  etc
    // create a polygon using the function
    // create a second polygon that accepts a different value of v
    // create a polyhedron by linking 1a, 1b and 2a with 2a, 2b and 1b.


/*

//      Curve:

bezier curve should be fully generic - watch lecture, yet again
bezier curve should be optimized. My pascals table is distinct form one in lecture. Look up "binomial series".
b spline my bezier

//      Profile:
profile should be n seperate bezier curves in a pattern
profile should take circle or and 2d shape



//      Polyhedron
to draw a pattern I translate forwad by diamter, roate rotate around center n number of time by n/360 degrees.
in this new way the profile should always be perpendicular to the central spine?

b spline surfaces       https://www.youtube.com/watch?v=qhQrRCJ-mVg
Bezier Formula          https://youtu.be/2HvH9cmHbG4?t=19m20s

Volume calculations of a polyhedron
*/