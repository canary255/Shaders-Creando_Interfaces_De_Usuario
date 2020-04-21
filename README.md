# Creando-Interfaces-de-Usuario
## Shaders - Ismael Aarab Umpiérrez

### Introducción
Realizar una propuesta de prototipo que haga uso al menos de un shader de fragmentos, sugiriendo que cree un diseño generativo o realice algún procesamiento sobre imagen.

![](ezgif.com-optimize.gif)

### Desarrollo
- Para este ejercicio, se realizó un simulador de batalla RPG, donde estás luchando contra un oponente que tiene cierta vida y le tienes que ir quitando poco a poco con los movimientos que tienes. Dichos movimientos usan la mecánica del "Piedra, papel, tijeras" para ver quién gana sobre quien y le resta puntos de vida.
- A medida que le vas quitando vida, la imagen y el fondo cambia:
  - Si le queda la mitad de vida, el fondo tendrá un shader que será un gradiente que va variando entre verde y azul y la imagen del enemigo va cambiando de color.
  - Si le queda un cuarto de vida, la imagen del enemigo tendrá un shader con efecto "Emboss", y el fondo tendrá el shader "Monjori".
- Una vez derrotado el oponente, aparecerá un mensaje donde dirá que has ganado, si fuiste derrotado, pues saldrá un mensaje de que has perdido.

### Instrucciones
 - "Flecha arriba y abajo" - Elige los movimientos.
 - "ENTER" - Ejecuta la acción del movimiento.
  
  
### Herramientas y Referencias
  
  - [Conversión video a GIF](https://imagen.online-convert.com/es/convertir-a-gif)
  
  - [Minim](http://code.compartmental.net/minim/)
  
  - [Música de fondo (Super Smash Bros - Master Hand Battle](https://www.youtube.com/watch?v=WyogowO4VW8)
  
  - [Processing 3](https://processing.org/)
