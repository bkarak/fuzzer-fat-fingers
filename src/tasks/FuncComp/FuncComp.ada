generic
   type Argument is private;      
package Functions is
   type Primitive_Operation is not null
      access function (Value : Argument) return Argument;
   type Func (<>) is private;
   function "*" (Left : Func; Right : Argument) return Argument;
   function "*" (Left : Func; Right : Primitive_Operation) return Func;
   function "*" (Left, Right : Primitive_Operation) return Func;
   function "*" (Left, Right : Func) return Func;
private
   type Func is array (Positive range <>) of Primitive_Operation;
end Functions;


package body Functions is
   function "*" (Left : Func; Right : Argument) return Argument is
   Result : Argument := Right;
   begin
      for I in reverse Left'Range loop
         Result := Left (I) (Result);
      end loop;
      return Result;
   end "*";
 
   function "*" (Left, Right : Func) return Func is
   begin
      return Left & Right;
   end "*";
 
   function "*" (Left : Func; Right : Primitive_Operation) return Func is
   begin
      return Left & (1 => Right);
   end "*";
 
   function "*" (Left, Right : Primitive_Operation) return Func is
   begin
      return (Left, Right);
   end "*";
end Functions;



with Ada.Numerics.Elementary_Functions;  use Ada.Numerics.Elementary_Functions;
with Ada.Text_IO;                        use Ada.Text_IO;
with Functions;
 
procedure FuncComp is
   package Float_Functions is new Functions (Float);
   use Float_Functions;
 
   Sin_Arcsin : Func := Sin'Access * Arcsin'Access;
begin
   Put_Line (Float'Image (Sin_Arcsin * 0.5));
end FuncComp;

