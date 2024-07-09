## Navegando en Editores de Código

Como desarrolladores de software, pasamos mucho tiempo editando código: depurando, agregando funciones y refactorizando. Una de las tareas más frecuentes que realizamos es insertar sentencias `print` para fines de depuración. Esta guía te ayudará a comprender cómo navegar por el código de manera efectiva, especialmente cuando uses Vim y LazyVim.

### Navegación en Diferentes Editores

**VSCode**

En VSCode, el mouse suele ser la forma más rápida de navegar. Las teclas de flecha, combinadas con Control, Alt o Cmd/Win, pueden mover el cursor en incrementos más grandes. Los atajos de teclado y la compatibilidad con Language Server facilitan la navegación semántica del código.

**Vim**

Vim admite la navegación con el mouse, pero sus combinaciones de teclas lo hacen poderoso para el uso solo con teclado. LazyVim, con sus complementos y combinaciones de teclas, lo mejora aún más.

### Navegación de Texto en LazyVim

**Plugin flash.nvim**

LazyVim incluye flash.nvim, una iteración moderna de EasyMotion para una navegación rápida dentro del texto visible.

#### Usando el Modo Seek

Activar el modo Seek: Presiona `s` en modo normal.
Escribe el caracter objetivo: Esto resalta las instancias de ese caracter.
Navega al objetivo: Escribe la etiqueta junto al caracter deseado.

#### Limitaciones del Modo Seek

Edición de Fin de Línea: El modo Seek puede no funcionar bien cerca de los finales de línea. En su lugar, usa `A` (modo insertar al final de la línea) o `$` (mover el cursor al final de la línea).

#### Desplazamiento de la Pantalla

Control-d / Control-u: Desplazar hacia abajo / arriba por media pantalla.
Control-f / Control-b: Desplazar hacia adelante / hacia atrás por una pantalla completa.
Control-y / Control-e: Desplazar una línea a la vez sin mover el cursor.
Modo z: Usa `zt`, `zb` y `zz` para posicionar el cursor en la parte superior, inferior o central de la pantalla.

#### Teclas de Flecha y Filosofía Vim

Teclas de Flecha: Evita usarlas para mejorar la eficiencia y reducir la tensión en las manos.
Teclas de Navegación Vim: Usa `h`, `j`, `k` y `l` para movimientos hacia la izquierda, abajo, arriba y derecha.

#### Contando

Prefijo con Conteo: La mayoría de los comandos se pueden prefijar con un conteo para repetir la acción varias veces (por ejemplo, `15k` para mover hacia arriba 15 líneas).

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

### Conclusión

Navegar por el código de manera eficiente es crucial para los desarrolladores. Vim, especialmente con las mejoras de LazyVim, ofrece herramientas poderosas para esto. Al dominar estas técnicas, puedes editar código de manera más efectiva y mejorar tu productividad general.
