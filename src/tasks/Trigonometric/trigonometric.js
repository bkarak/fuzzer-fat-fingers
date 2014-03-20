var
 radians = Math.PI / 4, // Pi / 4 is 45 degrees. All answers should be the same.
 degrees = 45.0,
 sine = Math.sin(radians),
 cosine = Math.cos(radians),
 tangent = Math.tan(radians),
 arcsin = Math.asin(sine),
 arccos = Math.acos(cosine),
 arctan = Math.atan(tangent);
 
// sine
document.write(sine + " " + Math.sin(degrees * Math.PI / 180));
// cosine
document.write(cosine + " " + Math.cos(degrees * Math.PI / 180));
// tangent
document.write(tangent + " " + Math.tan(degrees * Math.PI / 180));
// arcsine
document.write(arcsin + " " + (arcsin * 180 / Math.PI));
// arccosine
document.write(arccos + " " + (arccos * 180 / Math.PI));
// arctangent
document.write(arctan + " " + (arctan * 180 / Math.PI));
