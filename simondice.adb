WITH Ada.Integer_Text_IO, ada.Numerics.Discrete_Random, nt_console, ada.Text_IO, ada.Characters.Handling; 
USE Ada.Integer_Text_IO, nt_console, ada.Text_IO, ada.Characters.Handling;


PROCEDURE SimonDice IS
   
-- Tipos
type t_vec is array(1..100) of character;

subtype rango is character range '1'..'4';

PACKAGE Aleatorio IS NEW Ada.Numerics.Discrete_Random(rango); 
use aleatorio;

-- Modulos 

PROCEDURE Dibujar_Tablero IS
BEGIN
   Set_Background(Black); 
   Goto_Xy(20,5); 
   Put("                          "); 
   Goto_Xy(20,11); 
   put("                          ");
   Goto_Xy(20,17); 
   Put("                          "); 
   
   for i in 5..17 loop
      Goto_Xy(20,i); 
      Put("  "); 
      Goto_Xy(32,I); 
      put("  ");
      Goto_Xy(44,I); 
      put("  ");
   END LOOP; 
   
   set_background(gray);
end dibujar_tablero;

PROCEDURE Dibujar_Marco IS 
BEGIN
   set_background(black); 
   goto_xy(0,0);
   Put("                                                                                                                        "); 
   goto_xy(0,29);
   Put("                                                                                                                        ");   

   FOR I IN 1..29 LOOP 
      Goto_Xy(0,I); 
      Put("  "); 
      Goto_Xy(118,I); 
      Put("  ");
   END LOOP;   
   goto_xy(0,0);
end dibujar_marco;


PROCEDURE Dibujar_Titulo IS 
   
BEGIN 
   goto_xy(55,1);
   set_foreground(red); put("S");   
   Set_Foreground(green); Put("I");
   set_foreground(yellow); put("M");   
   set_foreground(blue); put("O");
   set_foreground(red); put("N ");
   set_foreground(green); put("D");
   set_foreground(yellow); put("I");
   set_foreground(blue); put("C");
   set_foreground(red); put_line("E");
END Dibujar_Titulo;


   PROCEDURE Dibujar_Luz(Num: character; dif: integer) IS 
   
      PROCEDURE Luz(x,y: integer; color: color_type; n:character) IS 
         
      BEGIN --PP        
         set_background(color);
         goto_xy(x,y);   put("          ");
         goto_xy(x,y+1); put("          ");
         goto_xy(x,y+2); put("          ");
         goto_xy(x,y+3); put("          ");
         goto_xy(x,y+4); put("          ");
         goto_xy(x+4,y+2); set_foreground(gray); put(n); 

      end luz;
   
   BEGIN 
      IF Num='1' THEN          --ROJO
         luz(22,6,red,num); bleep; delay 1.5; -- Dificultad
         luz(22,6,gray,num);
      
      ELSIF Num='2' THEN       -- VERDE 
         luz(34,6,green,num); bleep; delay 1.5;
         Luz(34,6,Gray,Num);
         
      ELSIF Num='3' THEN       -- AMARILLO 
         luz(22,12,yellow,num); bleep; delay 1.5;
         Luz(22,12,Gray,Num); 
      
      ELSIF Num='4' THEN       -- AZUL
         luz(34,12,blue,num); bleep; delay 1.5;
         Luz(34,12,Gray,Num);
         
      end if;
   end dibujar_luz;

-- Declaraciones

Gen: Generator; --variable generadora del package random
n: character; -- variable que guarda el valor random generado         
gano: boolean; -- variable que determina si el jugador gano o no la ronda
Dificultad: Integer; 
seleccion: character; -- variable que guarda la eleccion del jugador
Vec: T_Vec; -- Vector que almacena la secuencia de luces 
ultimo: integer; -- Almacena la posicion del ultimo elemento guardado en el vector      
punt: integer; -- Puntero que recorre el vector para buscar la secuencia de luces
rta:character; rta2: character;
puntaje: integer; -- Almacena los puntos del jugador
seguir: boolean; -- Determina si el jugador quiere seguir jugando o no

BEGIN -- Programa Principal 

rta:= 'n';
while to_lower(rta) /= 's' loop -- MAIN LOOP
   set_cursor(false);
   
   Clear_Screen(Gray); 
   
   goto_xy(55,1);
   Dibujar_Titulo;
   dibujar_marco;   

   set_foreground(black); set_background(gray);
   put_line("");
   goto_xy(56,4); put_line("1- Jugar");
   goto_xy(56,6); put("S- Salir");

   get_immediate(rta);
   Clear_Screen(Gray); 
   Dibujar_Titulo; 
       
if rta = '1' then
dibujar_marco; 
dibujar_tablero;
Gano:= True; 
ultimo:= 0; puntaje:= 0;

while gano = true loop

   ultimo:= ultimo+1; punt:= 1;
   -- Generar numero Aleatorio
   Reset(Gen); 
   N:= Random(Gen);          
   vec(ultimo):= n;       
   for i in 1..ultimo loop
      delay 0.3;
      Dibujar_Luz(vec(i), 2000); 
   end loop;
   set_background(gray);   

   LOOP -- Repeat
      set_foreground(black); set_cursor(true);
      goto_xy(60,7);       
      Get_immediate(Seleccion); set_cursor(false);

      if seleccion /= vec(punt) then
         gano:= false; set_foreground(black); goto_xy(56,7); put("PERDISTE"); skip_line; 
         
         seguir:= false;
         goto_xy(); put("Desea seguir jugando?(s/n): "); get_immediate(rta2); 
         if rta2 = 's' then 
            seguir:= true; 
         end if;
      else
         goto_xy(58,7);
         set_foreground(black); put("BIEN");
         DELAY 0.3; 
         set_foreground(gray); goto_xy(58,7); put("BIEN"); -- Borrar el cartel
         punt:= punt+1;          
      END IF; 
      EXIT WHEN (Gano = False) OR (Punt > Ultimo) or (seguir = false);  
      
      if gano = true  then
         puntaje:= puntaje+1; goto_xy(58,9); put("PUNTAJE: " & integer'image(puntaje));
      END IF;       
                  
   end loop;  -- End Repeat
   
            
end loop; -- End Main Game
end if;

end loop; -- MAIN LOOP

end SimonDice;

-- POR HACER -- 

-- UX
--2 Implementar sistema de mejores puntuaciones

















