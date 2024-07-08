### Objetos y Modo Pendiente de Operadores

#### Navegación por frases y párrafos:

- Moverse una frase hacia adelante: `)`
- Moverse una frase hacia atrás: `(`
- Moverse un párrafo hacia adelante: `}`
- Moverse un párrafo hacia atrás: `{`

#### Modo Unimpaired:

- `[(` y `])` para saltar a la apertura/cierre de paréntesis, llaves, o corchetes.
- `[[` y `]]` para saltar a la referencia anterior/siguiente de la variable bajo el cursor.
- `[c`, `]c`, `[f`, `]f`, `[m`, y `]m` para saltar a la definición anterior/siguiente de clases, funciones o métodos.
- `[C`, `]C`, `[F`, `]F`, `[M`, y `]M` para saltar al final de las clases, funciones o métodos.

#### Saltos por nivel de indentación:

- `[i` y `]i` para saltar al inicio/final del nivel de indentación actual.

#### Saltos a diagnósticos:

- `[d` y `]d` para saltar al diagnóstico (error, advertencia) anterior/siguiente.
- `[e`, `]e` para errores, `[w`, `]w` para advertencias, y `[s`, `]s` para errores ortográficos.

#### Modo Pendiente de Operador:

- Operadores como `c`, `d`, `y` y `>` requieren un movimiento adicional.
- Ejemplos: `cw` (cambiar palabra), `d$` (borrar hasta el final de la línea), `d}` (borrar párrafo), `d]i` (borrar hasta el final del nivel de indentación).
