# Plan Clínico BRAVE — Ficha de Cliente

Página web de una sola pieza (`index.html`) para el seguimiento de clientes de coaching físico/nutricional: nutrición, suplementos, hidratación, descanso, entrenamiento (gym + casa + WOD), seguimiento de progreso y motivación. Todo el estado (fotos, agua, historial, notas) se guarda en el `localStorage` del navegador del cliente, separado por `CLIENTE_SLUG`.

## Estructura del repositorio

```
.
├── index.html      # Toda la app: HTML + CSS + JS en un solo archivo
├── vercel.json     # Configuración mínima de despliegue en Vercel
├── .gitignore
└── README.md
```

## Personalizar para un cliente nuevo

Todo lo que cambia por cliente vive en **un solo bloque** cerca del final de `index.html` (buscar `CONFIGURACIÓN DEL CLIENTE`):

```js
const CLIENTE_SLUG    = 'SLUG_CLIENTE';        // ej: 'laura', 'camilo'
const CLIENTE_NOMBRE  = 'NOMBRE COMPLETO';     // ej: 'Laura Rojas'
const PLAN_INICIO     = '2026-07-09';          // fecha de inicio, formato YYYY-MM-DD
const PLAN_DIAS       = 30;
const PLAN_CODIGO     = 'BRV-2026-XXX';
const COACH_WA_NUM    = '573228757918';
const COACH_PIN       = '1801';
```

Además, dentro del archivo hay otros bloques marcados para editar (nutrición de 7 días, entrenamiento de 5 días, suplementos, checklist, hidratación, descanso, motivación). Están comentados en el encabezado del archivo.

> Nota: corregí una etiqueta `<html>` duplicada que traía el archivo original (`<html<html lang="es">`) y reemplacé la fecha placeholder `YYYY-MM-DD` por una fecha válida, ya que si no, el cálculo del ciclo de 30 días fallaba.

## Cómo subirlo a GitHub

Desde la carpeta del proyecto:

```bash
git init
git add .
git commit -m "Primera versión del plan BRAVE"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/TU_REPO.git
git push -u origin main
```

(Antes crea el repositorio vacío en GitHub desde github.com/new, sin README ni .gitignore para evitar conflictos.)

## Cómo desplegarlo en Vercel

**Opción A — desde la web (más simple):**
1. Entra a vercel.com y conecta tu cuenta de GitHub.
2. "Add New… → Project" y selecciona el repositorio que acabas de subir.
3. Vercel detecta que es un sitio estático (no necesita build command ni output directory). Dale a "Deploy".
4. En un par de minutos tendrás una URL tipo `tu-repo.vercel.app`.

**Opción B — desde la terminal:**
```bash
npm install -g vercel
vercel login
vercel        # despliegue de prueba
vercel --prod # despliegue a producción
```

## Flujo para actualizar la página (editar → GitHub → Vercel)

Una vez que tu repo está conectado a Vercel (ver sección de arriba), **no necesitas hacer nada especial en Vercel cada vez que actualices**: basta con subir el cambio a GitHub y Vercel lo despliega solo. El flujo normal es:

1. Edita `index.html` (rutinas, nutrición, fechas, lo que sea).
2. Guarda y sube el cambio a GitHub con el script incluido:
   ```bash
   ./actualizar.sh "Actualizo rutina de la semana 3"
   ```
   Esto hace `git add`, `git commit` y `git push` en un solo paso.
3. Vercel detecta el push automáticamente y despliega la nueva versión en 1-2 minutos. Puedes ver el progreso en tu dashboard de vercel.com.
4. Cuando termine, la misma URL (`tu-repo.vercel.app`) ya muestra la versión actualizada — no cambia de dirección.

Si prefieres hacerlo manualmente sin el script:
```bash
git add .
git commit -m "Descripción del cambio"
git push
```

### ¿Y si quiero controlar el despliegue desde GitHub Actions en vez de la integración nativa?

Incluí un workflow opcional en `.github/workflows/deploy.yml`, **desactivado por defecto** (solo funciona si configuras 3 secrets en GitHub: `VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`, como se explica en los comentarios del archivo). Para la mayoría de los casos **no es necesario**: la integración nativa de Vercel con GitHub ya hace esto automáticamente.

## Un cliente por proyecto vs. multi-cliente

Este archivo está pensado como plantilla: la forma más simple es **un repositorio y un despliegue de Vercel por cliente** (cada uno con su propio `CLIENTE_SLUG` y su propia URL). Si vas a tener varios clientes, te recomiendo:
- Guardar esta plantilla en una rama `main` limpia.
- Por cada cliente nuevo, crear una rama o un repo aparte, editar el bloque de configuración, y desplegar.

Si prefieres, también puedo ayudarte a armar una versión donde un solo despliegue sirva varias fichas de cliente (por ejemplo con rutas `/laura`, `/camilo`), pero eso requiere separar el archivo en varias páginas.
