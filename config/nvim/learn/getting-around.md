## Navegando en Editores de Código

### Navegación de Texto en LazyVim

#### Usando el Modo Seek

Activar el modo Seek: Presiona `s` en modo normal.
Escribe el caracter objetivo: Esto resalta las instancias de ese caracter.
Navega al objetivo: Escribe la etiqueta junto al caracter deseado.

#### Desplazamiento de la Pantalla

Control-d / Control-u: Desplazar hacia abajo / arriba por media pantalla.
Control-f / Control-b: Desplazar hacia adelante / hacia atrás por una pantalla completa.
Control-y / Control-e: Desplazar una línea a la vez sin mover el cursor.
Modo z: Usa `zt`, `zb` y `zz` para posicionar el cursor en la parte superior, inferior o central de la pantalla.

#### Modo Buscar

Activación del Modo Buscar: Presiona `f` seguido del caracter objetivo para saltar a él.
Conteos en Modo Buscar: Usa conteos para saltar a instancias posteriores del caracter (por ejemplo, `3f` para saltar a la tercera ocurrencia).

#### Moviéndose por Palabras

Movimientos de Palabras: Usa `w` para moverte al comienzo de la siguiente palabra, `e` para moverte al final de la palabra actual/siguiente, y `b` para moverte hacia atrás.
Palabras Grandes: Usa `W`, `E` y `B` para moverte por palabras delimitadas por espacios en blanco.

#### Objetivos de Línea

Comienzo/Fin de Línea: Usa `^` para moverte al inicio del texto, `$` para moverte al final y `0` para moverte al principio.
Último Caracter No en Blanco: Usa `g_`.

#### Saltar a Líneas Específicas

Ir a Línea: Usa `línea_númeroG` (por ejemplo, `100G`) para saltar a una línea específica.
