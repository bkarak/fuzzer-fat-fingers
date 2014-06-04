package Ethiopian is
   function Multiply(Left, Right : Integer) return Integer;
end Ethiopian;

package body Ethiopian is
   function Is_Even(Item : Integer) return Boolean is
   begin
      return Item mod 2 = 0;
   end Is_Even;
 
   function Double(Item : Integer) return Integer is
   begin
      return Item * 2;
   end Double;
 
   function Half(Item : Integer) return Integer is
   begin
      return Item / 2;
   end Half;
 
   function Multiply(Left, Right : Integer) return Integer is
      Temp : Integer := 0;
      Plier : Integer := Left;
      Plicand : Integer := Right;
   begin
      while Plier >= 1 loop
         if not Is_Even(Plier) then
            Temp := Temp + Plicand;
         end if;
         Plier := Half(Plier);
         Plicand := Double(Plicand);
      end loop;
      return Temp;
   end Multiply;
end Ethiopian;

with Ethiopian; use Ethiopian;
with Ada.Text_Io; use Ada.Text_Io;
 
procedure Mult is
   First  : Integer := 17;
   Second : Integer := 34;
begin
   Put_Line(Integer'Image(First) & " times " &
      Integer'Image(Second) & " = " &
      Integer'Image(Multiply(First, Second)));
end Mult;

