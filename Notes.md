# Nombre del proyecto: AsisMed
# Notas del Proyecto: Sistema de Administración de Clínicas Médicas

## Arquitectura
- **Backend**: Ruby on Rails (Heroku)
    - GraphQL
- **Base de datos**: PostgreSQL
- **Frontend**: Flutter (multiplataforma)

## Funcionalidades por resolver
1. Enviar recordatorios de citas por WhatsApp con archivos `.ics`.
2. Alternativa: Enviar recordatorios por correo electrónico.
3. Usar Active Storage para manejar archivos `.ics`.
4. Priorizar correos electrónicos por simplicidad y costo.

## Pendientes
- Implementar integración con WhatsApp Business API.
- Diseñar la interfaz de Flutter para la gestión de citas.

## Modelos
AGENDAS (talvez no sea necesario un modelo,  aunque sí una vista si hacemos una consulta a las citas agrupadas por fecha)
	- Una agenda por usuario
	- Talvez la asistente también necesita una agenda para anotar los pendientes por fecha
	- CAMPOS:
		- Fecha
		- Hora
		- Tipo de evento (cita, consulta, expediente)
		- Evento

USUARIOS
	- Agregar multifactor
	- Sería JWT una buena idea por las llamadas desde el front?
	- Manejar sesiones aún con JWT, verificar cuánto tiempo se recomienda de validez para los tokens
	- CAMPOS:
		- REQUERIDO Usuario (puede ser correo para simplificar)
		- REQUERIDO Contraseña (verificar parámetros para contraseña fuerte)
		- REQUERIDO Perfil (tipo de usuario (médico, asistente, administrador, etc))
		- REQUERIDO APaterno
		- REQUERIDO AMaterno
		- REQUERIDO Nombre(s)
		- Firma (ActiveStorage a Google Cloud Storage)

CITAS
	- CAMPOS:
		- REQUERIDO Fecha
		- REQUERIDO Hora
		- REQUERIDO Paciente (RELACION hacia PACIENTES, una CITA pertenece a un PACIENTE)
		- REQUERIDO Médico/Consultorio (talvez el registro del Médico tiene registrado en qué consultorio labora)
		- Indicaciones (details)
    - Nota_medica (RELACION hacia NOTAS_MEDICAS, una CITA puede tener una NOTA_MEDICA)

PACIENTES
	- CAMPOS:
		- REQUERIDO APaterno
		- REQUERIDO AMaterno
		- REQUERIDO Nombre(s)
		- REQUERIDO Fecha de nacimiento
		- REQUERIDO Teléfono
    - REQUERIDO Correo Electrónico
		- REQUERIDO Sexo (Masculino, Femenino)
		- Estado Civil (RELACION hacia ESTADOS_CIVILES)
		- Ocupación
		- Escolaridad (RELACION hacia ESCOLARIDADES)
		- Código postal
		- Estado
		- Municipio
		- Colonia
		- Dirección
		- Originario
		- Religión
		- Interrogatorio (Directo, Indirecto)
		- Aseguradora (RELACION hacia ASEGURADORAS)

ESCOLARIDADES (Los posibles valores del campo Descripción son: No Aplica, Primaria, Secundaria, Preparatoria, Licenciatura, Maestría, Doctorado)
  - CAMPOS:
    - REQUERIDO Descripción

ESTADOS_CIVILES (Los posibles valores del campo Descripción son: Soltero(a), Casado(a), Viudo(a), Union Libre)
  - CAMPOS:
    - REQUERIDO Descripción

ASEGURADORAS (Los posibles valores del campo Descripción son: IMSS, ISSSTE, SEGURO POPULAR, GASTOS MEDICOS MAYORES, OTROS)
  - CAMPOS:
    - REQUERIDO Descripción

NOTAS_MEDICAS
  - CAMPOS
    - REQUERIDO Cita (RELACION hacia CITAS, una NOTA_MEDICA pertenece a una CITA)
    - TA (Valor posible 120/80)
    - SpO2 (Valor posible 98%)
    - Temperatura (Valor posible 35.4°)
    - Glucosa (¿Valores posibles?)
    - FR	(¿Valores posibles?)
    - FC	(¿Valores posibles?)
    - Peso (Valor posible 56.4kg)
    - Estatura (Valor posible 1.56 m)
    - Padecimiento actual
    - Exploración física
    - Plan de Manejo y Tratamiento
    - Pronóstico
    - (RELACION hacia NOTA_DIAGNOSTICOS, una NOTA_MEDICA tiene muchas NOTA_DIAGNOSTICOS)

NOTA_DIAGNOSTICOS
  - Posibles tipos de diagnóstico
    - Diagnóstico Principal
    - Diagnóstico Secundario
    - 2do Diagnóstico Secundario
    - 3er Diagnóstico Secundario
    - 4o Diagnóstico Secundario
  - CAMPOS
    - REQUERIDO Nota_medica (RELACION hacia NOTAS_MEDICAS, una NOTA_DIAGNOSTICO pertenece a una NOTA_MEDICA)
    - Clave (RELACION hacia DIAGNOSTICOS, una NOTA_DIAGNOSTICO tiene un DIAGNOSTICO)
    - Principal (bandera de si es o no el diagnóstico principal (si | no))

DIAGNOSTICOS
  - CAMPOS
    - REQUERIDO Clave
    - REQUERIDO Descripción

RECETAS
  - CAMPOS
    - REQUERIDO Nota_medica (RELACION hacia NOTAS_MEDICAS, una RECETA pertenece a una NOTA_MEDICA)
    - REQUERIDO Nombre del Medicamento
    - REQUERIDO Dósis

RECETA_MEDICAMENTOS (JOIN TABLE entre RECETAS y MEDICAMENTOS)
  - CAMPOS
    - Receta (RELACION hacia RECETAS)
    - Medicamento (RELACION hacia MEDICAMENTOS)
    - Dósis

INDICACIONES
  - CAMPOS
    - Descripción

MEDICAMENTOS
  - CAMPOS
    - Descripción

DIAGNOSTICOS_INDICACIONES (JOIN TABLE entre DIAGNOSTICOS e INDICACIONES)
  - CAMPOS
    - Indicación (RELACION hacia INDICACIONES)
    - Diagnóstico (RELACION hacia DIAGNOSTICOS)

LABORATORIOS
  - CAMPOS
    - División_laboratorios (RELACION hacia DIVISIONES_LABORATORIOS, un LABORATORIO pertenece a una DIVISION_LABORATORIOS)
    - Clave Div
    - Descripción

DIVISIONES_LABORATORIOS
  - CAMPOS
    - Descripción
    - Clave Div

GABINETES
  - CAMPOS
    - División_gabinetes (RELACION hacia DIVISIONES_GABINETES, un LABORATORIO pertenece a una DIVISION_GABINETES)
    - Clave Div
    - Descripción

DIVISIONES_GABINETES
  - CAMPOS
    - Descripción
    - Clave Div

FAMILIARES
  - CAMPOS
    - Familiar

PADECIMIENTOS
  - CAMPOS
    - Descripción
    - Tipo (hasta ahora solo se me ocurre 1 = Generales, 2 = Cardiovasculares)

ANT_HEREDO_FAMILIARES
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un HEREDO_FAMILIAR pertenece a un PACIENTE)
    - Familiar (RELACION hacia FAMILIARES, un FAMILIAR puede tener varios HEREDO_FAMILIARES)
    - Padecimiento (RELACION hacia PADECIMIENTO, un PADECIMIENTO puede tener varios HEREDO_FAMILIARES) (Diabetes, Hipertensión, Cardiopatía, Dislipidemia, Cancer, Otro (si se selecciona otro se puede capturar libremente))

ANT_NO_PATOLOGICOS
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un ANT_NO_PATOLOGICO pertenece a un PACIENTE)
    - Habitad (Urbano, Rural)
    - Básicos (Sí, No)
    - Viajes_extrangero (Sí -> Hace cuánto, Dónde | No)
    - Cuándo
    - Fimicos (Positivo, Negativo)
    - Actividad_física (Sí -> Cuál, Horas por Semana | Sedentario)
    - Horas_por_semana

ANT_PATOLOGICOS
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un ANT_PATOLOGICO pertenece a un PACIENTE)
    - Tabaquismo (Positivo -> Cuántos cigarros por día, Años fumando, Suspendido hace xxx años | Negativo)
    - Cigarros_por_día
    - Años_fumando
    - Suspendido_hace
    - Etilismo (Positivo -> Qué Tipo, Cuántas por Semana | Negativo)
    - Alcohol_tipo
    - Alcohol_veces_por_semana
    - Drogas (Positivo -> Qué Tipo, Cuántas por Semana | Negativo)
    - Drogas_tipo
    - Drogas_veces_por_semana
    - Biomasa (Positivo | Negativo)
    - Alergias (Positivo -> Cuál, Qué reacción tuvo | Negativo) (Se pueden agregar varias alergias)
    - Cirugías (Sí -> Cuál, Qué Año, Complicación | No) (Se pueden agregar varias cirugías)
    - Fracturas (Sí -> Cuál, Qué Año, Complicación | No) (Se pueden agregar varias fracturas)
    - Transfusiones (Sí -> Qué Año, Porqué | No) (Se pueden agregar varias transfusiones)

ALERGIAS
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un PACIENTE puede tener varias ALERGIAS)
    - Alergia
    - Reacción

CIRUGIAS
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un PACIENTE puede tener varias CIRUGIAS)
    - Cirugía
    - Año
    - Complicación

FRACTURAS
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un PACIENTE puede tener varias FRACTURAS)
    - Fractura
    - Año
    - Complicación

TRANSFUSIONES
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un PACIENTE puede tener varias TRANSFUSIONES)
    - Transfusión
    - Año
    - Motivo

CRONICO_DEGENERATIVAS
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un PACIENTE puede tener varias CRONICO_DEGENERATIVAS)
    - Padecimiento
    - Año_diagnóstico

CARDIOVASCULARES
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un PACIENTE puede tener varias CARDIOVASCULARES) (Son padecimientos de tipo 2 = Cardiovascular)
    - Año_diagnóstico
    - Procedimiento

GINECO_OBSTETRICO
  - CAMPOS
    - Paciente (RELACION hacia PACIENTES, un GINECO_OBSTETRICO pertenece a un PACIENTE)
    - Menarca
    - Frecuencia
    - Duración
    - Cantidad
    - Dismenorrea
    - Inicio_actividad_sexual
    - Embarazos
    - Partos
    - Abortos
    - Cesáreas
    - Método_anticonceptivo
    - Ultima_menstruación
    - ETS
    - Menopausia
    - Climaterio
    - Papanicolaou
    - Resultado


REPORTES (se exportan a un xls y se abre el Excel):
	- Se basan en fechas de inicio y fin como parámetros y puedes entregar:
		- Listado de pacientes Agendados
		- Listado de Pacientes Atendidos
		- Listado de Pacientes Cancelados
		- 20 Principales motivos de Atención
		- Censo de pacientes Diabetes
		- Censo de Pacientes Hipertensión
		- Censo de Pacientes CACU
		- Censo de Pacientes CAMAMA
		- Listado Nominal de Pacientes sujetos a VE
		- Dx Sujetos a Vigilancia Epidemiológica
		- Listado Qx de Pacientes Programados
		- Listado Qx de Pacientes Cancelados
		- Listado Qx de Pacientes Operados

Además de las consultas obvias como Obtener el paciente y sus padecimientos, las citas de hoy con algo de información del paciente, etc