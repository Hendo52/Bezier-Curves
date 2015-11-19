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
 
//creates a set of profile coords from the polygon radius (pr) and polygon sides (ps) variables                   
function profilecoords  ()        = [for(i=[0:1:ps-1])[pr*(cos(360/ps*i)), pr*(sin(360/ps*i)),0]];


//creates the pink faces
function profilefaces   ()        = [for(i=[0:1:ps-1])[0,i,i+1]];
// The polyhedrons verticy coordinates
function phcoords       ()        = [for(i=[1:1:ps-1],j=[0:1/res:1]) profilecoords()[i]+curve(j)];
    
//These functions create the numbers that order the faces in the polygon. The pattern is bottom left of the rightangled triangle, top, right. Repeat towards the top, then repeat counter clockwise. The
function encoding1      (j)        = [for(i=[0:1:res-2]) [i,i+1,i+res]+[j,j,j] ];
function encoding2      ()         = [for(j=[0:res:res*ps])  encoding1(j)];
function encoding3 		() 		   = [for(i=[0:1:ps-1], j=[0:1:res-1]) encoding2()[i][j]];


polyhedron( points= phcoords (), faces = encoding3(), convexity = 1 );   

//a debugging sphere useful for checking which order the coords are being generated in.
translate (phcoords()[209])color ("green") sphere(3);



 
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
             ([  50,   50,  275 ])], order=5, controls=true, size=2.5,  res=18, ps=25, pr=8,
        p0a = [   0,    0,    0 ],
        pna = [   0,    0,   90 ],   red = 0.4, green = 0, blue = 0.4 );







