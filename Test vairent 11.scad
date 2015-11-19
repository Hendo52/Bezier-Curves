// N Degree Bezier Curve Test
/* So many problems
1. No Bernstein polynomails (makes it really computationally ineffecient. This will become a big problem later.)
2. Curve formula is quartic, not generic 
3. Curve is bezier not bezier spline. aka b-spline. Creates a problem for long twisty curves (see 1.)
3. Profile coordinates do not rotate so that they are perpendicular to the curve (view from side)
4. The last polygon in each stack of triangles causes a problem
5. The encoding function is poorly formatted and that causes problems when I try to input it to other things. This should be a simple matter of concatinating them but I cant get this to work.
6. More than half the polygons are missing for 3 different reasons.
    a) upside down triangles are not being generated yet (easy to fix)
    b) top most layer is not being generated because there is no profile at the very top (easy to fix)
    c) two towers of traingles are missing (!!!unknown cause!!!)

*/


module bezier (ControlMatrix,order,showcontrols,size, res, ps, pr, p0a, pna, red,green,blue)
{
//These create a quartic cubic curve. See this gif 
//takes in tick, outputs curve values
// https://en.wikipedia.org/wiki/B%C3%A9zier_curve#/media/File:B%C3%A9zier_4_big.gif

function a1             (t)       = (1-t)*CM[0]+t*CM[1];
function a2             (t)       = (1-t)*CM[1]+t*CM[2];
function a3             (t)       = (1-t)*CM[2]+t*CM[3];
function b1             (t)       = (1-t)*a1(t)+t*a2(t);
function b2             (t)       = (1-t)*a2(t)+t*a3(t);
function curve          (t)       = (1-t)*b1(t)+t*b2(t); 

//factorials takes in integer n returns factorial of n
function fac            (f)       = (f==0?1:fac(f-1)*f);  
//combinations, takes in n and k and returns n choose k
function comb           (n,k)     = (fac(n))/(fac(k)*(fac(n-k)));
//determines the length of the matrix CM
function order          (CM)      = (len(CM)-1);     
//sigma? I think this is a function that does summations. Maybe it works, maybe it doesnt
function sum (n) = ((n*(n+1))/2);
//Bernstein's rule takes in intergers i,n,t and returns bernstien polynomial value.
function bern (i,n,t) = (comb(n,i))*(pow(t,i))*(pow(1-t,n-i));
//Pascals rule takes in 
function Prule (x,y) = (y>x?0:(y==0?1:(x==y?1:comb((x-1),y)+comb((x-1),(y-1)))));
//a line of pascals triangle
function Pline (L) = [for(i=[0:1:L])Prule(l,i)];
//a matrix of pascals triangle values
function Pmatrix (n) = [for(i=[0:1:n])[for(j=[0:1:n])Prule(i,j)]];
// a matrix of ticks (Bernstein)
function TM (t) = [for(i=[0:1:(order(CM))])[pow(t,(order(CM)-i))]];
// a matrix of Bernstein polynomials
function bernmatrix (n,t) = [for(i=[0:1:3])[for(t=[0:1:3])(bern (i,i,-order))]];
  
//creates a set of profile coords from the polygon radius (pr) and polygon sides (ps)variables                   
function profilecoords  ()        = [for(i=[0:1:ps-1])[pr*(cos(360/ps*i)), pr*(sin(360/ps*i)),0]];
//creates the pink faces 
function profilefaces   ()        = [for(i=[0:1:ps-1])[0,i,i+1]];
// The polyhedrons verticy coordinates
function phcoords       ()        = [for(i=[1:1:ps-1],j=[0:1/res:1]) profilecoords()[i]+curve(j)];
    
//These functions create the numbers that order the faces in the polygon. The pattern is bottom left of the rightangled triangle, top, right. Repeat towards the top, then repeat counter clockwise.
function encoding1      (j)        = [for(i=[0:1:res-2]) [i,i+1,i+res]+[j,j,j] ];
function encoding2      ()         = [for(j=[0:res:res*ps])  concat(encoding1(j))];


echo(encoding2());  
//echo([for(i=[0:1:1])encoding2()[i]]);
echo(concat(encoding2())); //does nothing
echo(concat([[1],[2],[3],[4]])); 

polyhedron( points= phcoords (), faces = encoding2()[1], convexity = 1 );   

// This is the same as the echo except with the excess brackets taken out. I cant seem to get the concat function working.
/*
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
*/
//a debugging sphere useful for checking which order the coords are being generated in.
translate (phcoords()[0])color ("green") sphere(3);




  
module profile (ps,pr,p0a,pna)  {   for(j=[0:1:(ps-2) ]) color([j/ps,j/ps,0])
polyhedron(points = [ for(i=[0:1:(ps-1)]) profilecoords()[i]],faces = [ for(i=[0:1:(ps-2)]) profilefaces()[i]],convexity=1);  
    
    
/*profileS*/ /* for (i=[0:1:ps-1])translate(profilecoords()[i]) color([i/ps,i/ps,i/ps]) sphere(1.5,$fn=30); */}  
            
/*Curve   */  for (t = [0:1/res:1]) {translate(curve(t))color([red,green,blue])profile (ps,pr);}

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





