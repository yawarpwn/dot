## Abriendo Archivos

En el capítulo anterior, aprendimos sobre las formas tradicionales de abrir archivos en Vim usando el comando `:edit` o directamente desde la terminal con `nvim nombre_del_archivo`. Si bien estos métodos son útiles, LazyVim ofrece alternativas modernas para navegar y abrir archivos a través de selectores de archivos.

## Introducción a los Selectores de Archivos

LazyVim incluye dos complementos de selector: Telescope (habilitado por defecto) y fzf.lua. Ambos ofrecen una interfaz basada en listas para seleccionar elementos, como archivos, búferes o resultados de búsqueda. Los selectores facilitan diversas tareas con búsqueda difusa y capacidades de vista previa, haciendo que la navegación de archivos sea eficiente.

## Uso del Selector Telescope

**Conceptos básicos del selector de archivos:**

      * Abre Neovim y navega a un directorio de proyecto.
      * Usa Espacio Espacio para abrir el selector "Archivos en el proyecto actual". Esta combinación de teclas está diseñada para un fácil acceso.

**Búsqueda difusa:**

      * Comienza a escribir el nombre del archivo en el área de entrada del selector. El selector filtra los resultados según los caracteres que ingresas, realizando una búsqueda difusa.

**Combinaciones de teclas:**

      * Modo inserción: Escribe para buscar.
      * Modo normal: Presiona Escape para entrar al modo normal dentro del selector. Usa j/k para navegar por los resultados, h/l para mover el cursor dentro del cuadro de entrada e i/a para volver al modo de inserción.
      * Modo Seek: Presiona s para etiquetar cada línea en el selector con un carácter. Presiona el carácter correspondiente para seleccionar una línea y Enter para abrir el archivo.

**Cerrando el selector:** Presiona Escape dos veces para cerrar el selector.

## Diferencias entre raíz y CWD

- Directorio raíz: Normalmente inferido por el Protocolo del servidor de lenguaje (LSP) basado en archivos de proyecto (por ejemplo, package.json, carpeta .git).
- CWD (Directorio de trabajo actual): El directorio desde el que inicias Neovim. Cámbialo dentro de Neovim usando `:cd ruta/al/directorio`.

Usa Espacio f f para "Buscar archivos (directorio raíz)" y Espacio f F para "Buscar archivos (cwd)" para elegir entre buscar desde la raíz o el directorio de trabajo actual.

## Uso del selector fzf.lua

LazyVim también admite fzf.lua como alternativa a Telescope, ofreciendo una interfaz familiar para los usuarios de la herramienta de línea de comandos fzf y un rendimiento potencialmente mejor.

## Habilitando fzf.lua

**Habilita fzf.lua:**

      * Escribe `:LazyExtras<Enter>`.
      * Selecciona `editor.fzf` y presiona x.
      * Espera la instalación y reinicia Neovim.

**Uso de fzf.lua:**

      * Área de entrada en la parte superior izquierda.
      * Usa Control-\ seguido de Control-n para entrar al modo normal.
      * Navega y selecciona archivos de manera similar a Telescope, pero con algunas diferencias en las combinaciones de teclas (por ejemplo, Control-x para la selección basada en etiquetas).

## Complemento Neo-tree.nvim

Neo-tree ofrece una barra lateral familiar con vista de árbol, optimizada para el uso del teclado.

## Uso de Neo-tree

**Abrir Neo-tree:**

      * Usa Espacio e para el directorio raíz o Espacio E para cwd.

**Navegación:**

      * Usa j/k para moverte hacia arriba y hacia abajo, Enter para expandir carpetas o abrir archivos.
      * Usa Retroceso para navegar a un directorio superior.

**Manipulación de archivos:**

      * Eliminar: d
      * Agregar: a (archivo/carpeta), A (solo carpeta)
      * Renombrar: r
      * Cortar/Copiar/Pegar: x (cortar), y (copiar), p (pegar)

**Modo filtro:** Accede con / para limitar la vista a archivos coincidentes, aunque los selectores generalmente son más efectivos.

## La Alternativa mini.files

mini.files ofrece una experiencia de administrador de archivos en columna que se integra perfectamente con las combinaciones de teclas del modo normal de Neovim.

## Uso de mini.files

**Habilitar mini.files:**

      * Habilítalo como un Lazy Extra similar a fzf.lua.

**Gestión de archivos:**

      * Edita listados de directorios como un búfer de texto normal.
      * Usa o para crear una nueva línea e ingresar un nombre de archivo en modo inserción
