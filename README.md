<p align="center">
  <a title="'test' workflow Status" href="https://github.com/susanacanel/proyectos-vhdl/actions?query=workflow%3Atest"><img alt="'test' workflow Status" src="https://img.shields.io/github/workflow/status/susanacanel/proyectos-vhdl/test?longCache=true&style=flat-square&label=test&logo=github%20actions&logoColor=fff"></a><!--
  -->
  <a title="YouTube channel 'SusanaCanel'" href="https://www.youtube.com/c/SusanaCanel"><img alt="YouTube channel 'SusanaCanel'" src="https://img.shields.io/badge/YouTube-SusanaCanel-red?longCache=true&style=flat-square&logo=youtube"></a><!--
  -->
</p>

# Proyectos VHDL

Este repositorio contiene archivos de descripciones hardware y testbenchs en VHDL; todos editables bajo licencia CC0.

## Integración continua

En este repositorio se realiza [integración continua](https://es.wikipedia.org/wiki/Integraci%C3%B3n_continua) del código. Esto quiere decir que, cada vez que se publica alguna actualización, se ejecutan automáticamente todos los testbench. Así, los usuarios pueden [ver](https://github.com/susanacanel/proyectos-vhdl/actions) qué resultado esperar, antes de descargar y ejecutar el código en sus equipos.

Concretamente, se utiliza el servicio [GitHub Actions](https://github.com/features/actions). En el mismo, la acción [setup-ghdl-ci](https://github.com/ghdl/setup-ghdl-ci) se utiliza para instalar [GHDL](https://github.com/ghdl/ghdl). GHDL es un analizador, compilador, simulador y sintetizador para VHDL. Es libre y gratuito, por lo que se puede utilizar en servicios públicos, a diferencia de otros simuladores (comerciales).

## Curso VHDL

El contenido de este repositorio es material complementario de una serie de videotutoriales que se han publicando en el canal de YouTube [SusanaCanel](https://www.youtube.com/c/SusanaCanel) durante los últimos años. A continuación, se listan enlaces a todos ellos, para facilitar la visualización de forma ordenada.

- [000. ¿Qué es VHDL? ¿Qué es un CPLD? ¿Qué es una FPGA?](https://www.youtube.com/watch?v=dWKlh3fZl_c)
- [001.1 Descarga free del Quartus II. Altera (actual Intel). Ya no es posible bajar la 9.1.](https://www.youtube.com/watch?v=YauHQsYe1wg)
- [001.2. Introducción. Descripción: AND2 por ecuaciones. Uso del Quartus II.](https://www.youtube.com/watch?v=a20txJbaV7c)
- [002. Compilación y simulación: compuerta AND de 2 entradas. Quartus II, 9.1.](https://www.youtube.com/watch?v=mYsK0KoETu4)
- [003. Descripción: compuerta AND2 con when-else. Prioridades.Quartus II, 9.1.](https://www.youtube.com/watch?v=-1JZxchDNeA)
- [004. Descripción: compuerta AND2 con with select. Concatenación. Tabla de verdad.](https://www.youtube.com/watch?v=JDr4tJTZjVE)
- [005. Simulación de una AND2 definida por tabla de verdad. Quartus II, 9.1.](https://www.youtube.com/watch?v=QicJ7Ej2_7M)
- [006. Descripción: AND2 con puntero. Numeric_std. Casting. To_integer.](https://www.youtube.com/watch?v=9iITc-pHBL8)
- [007. Descripción: decodificador 3 a 8 con habilitación. Concatenación. With-select.](https://www.youtube.com/watch?v=m_sGZptSEe0)
- [008. Simulación de un decodificador de 3 a 8. Quartus II, 9.1.Generación de señales.](https://www.youtube.com/watch?v=BFfRIyd9zK8)
- [009. Visor de esquemáticos (Viewers). Quartus II. RTL, Technology Map.](https://www.youtube.com/watch?v=igDe9bRoyTY)
- [010. Descripción y simulación: multiplexor de 4 canales. With-select. Quartus II,9.1.](https://www.youtube.com/watch?v=LngtnzPVU3I)
- [011. Descripción: codificador de prioridad, señal de grupo. When-else. Simulación.](https://www.youtube.com/watch?v=aZ3jZNI52N0)
- [012. Descripción: conversor de BCD Natural a Aiken. Numeric_std.Simulación.](https://www.youtube.com/watch?v=iJbdA18rglk)
- [013. Descripción: comparador genérico de enteros. Numeric_std. When-else.Casting.](https://www.youtube.com/watch?v=6YfPZKvKlaE)
- [014. Descripción: conversor genérico Gray a Natural. Generic, XOR, Subíndices.](https://www.youtube.com/watch?v=mvz8jaOafWw)
- [015. Descripción: multiplexor genérico. Habilitación. Numeric_std.Casting.](https://www.youtube.com/watch?v=DtakxchcRAM)
- [016. Descripción de un sumador de magnitudes genérico. Numeric_std, unsigned](https://www.youtube.com/watch?v=f0KHRFsTppM)
- [017. Descripción de un multiplicador genérico de enteros. Numeric_std, signed.](https://www.youtube.com/watch?v=vXmvVDMj7rI)
- [018. Descripción de un sumador-restador genérico de enteros. Numeric_std](https://www.youtube.com/watch?v=JV4O69iFZNI)
- [019. Descripción de una ROM como conversor de binario natural a Gray.](https://www.youtube.com/watch?v=ufagWGD9Wy8)
- [020. Descripción de un decodificador genérico mediante process. Lista de sensibilidad.](https://www.youtube.com/watch?v=P8EfRfPFkP0)
- [021. Descripciónde un árbol de Paridad genérico mediante process, for...loop, variable.](https://www.youtube.com/watch?v=UjywM3PFjIs)
- [022. Descripción: memoria estática, asincrónica con bus de datos bidireccional, SRAM.](https://www.youtube.com/watch?v=5MokoXlPq1o&feature=youtu.be)
- [023. Descripción algorítmica de una NOR genérica. for...loop, if, process. Simulación](https://www.youtube.com/watch?v=qBRS11dh2o0)
- [024. Descripción algorítmica de una NAND genérica. for...loop, if, process. Simulacion](https://www.youtube.com/watch?v=oYbK_Gjp6aI)
- [025. Descripción estructural de un circuito. Package, RTL, Technology Viewer.](https://www.youtube.com/watch?v=RJwa__v48n8)
- [026.1. Descripción: display de 7 segmentos para exhibir comparación o suma de BCDs.](https://www.youtube.com/watch?v=Y_QyV4EaJno)
- [026.2 VHDL. Hardware sintetizado y efectos de eliminación de una señal de la descripción.](https://www.youtube.com/watch?v=_nz_TNJBOGM)
- [026.3. Ejecución del circuito sintentizado en la plaqueta DE1 de Altera.](https://www.youtube.com/watch?v=3u7hmYmxF-s)
- [026.4. Modificación de la descripción del circuito sintetizado del sumador y comparador.](https://www.youtube.com/watch?v=oPEkg0s_Dm8)
- [027.0. Recapitulación y próximos screencasts.](https://www.youtube.com/watch?v=0JB68AJ-2ac)
- [027.1.Descarga del ModelSim del sitio de Intel-Altera.](https://www.youtube.com/watch?v=-Kh1ivUbGLY)
- [028.1. Uso sencillo del ModelSim.TestBench para la AND2ecu.](https://www.youtube.com/watch?v=ECCojuso5nU)
- [028.2. Simulación con ModelSim generando formas de onda con Testbench.](https://www.youtube.com/watch?v=NnUWXXSm27M)
- [029.1. Explicación de un testbench para el decodificador de 3 a 8 con habilitación.](https://www.youtube.com/watch?v=SR_fcMu4ox4)
- [029.2. Testbench usando &quot;for&quot; para el Decodificador 3 a 8.](https://www.youtube.com/watch?v=bW4OGe_iGBM)
- [030.1. Testbench para el multiplexor de 4 canales. Análisis de errores.](https://www.youtube.com/watch?v=heUq3zRRQWI)
- [030.2. Testbench optimizado para el multiplexor de 4 canales. Uso &quot;for&quot; anidados.](https://www.youtube.com/watch?v=3Zq5L2I9Q1Y)
- [030.3. Testbench de un multiplexor genérico con entrada de habilitación.](https://www.youtube.com/watch?v=iWEEqdE2lek)
- [031. Testbench para el codificador de prioridad de 4a2](https://www.youtube.com/watch?v=dGqn_GS6rgg)
- [032. Testbench para el conversor BCD binario natural a Aiken.](https://www.youtube.com/watch?v=VV4L38-6bQ4)
- [033. Testbench para el comparador genérico de enteros. Tablas (array)](https://www.youtube.com/watch?v=JNdnBBfbHsE)
- [034. Testbench para el conversor genérico de Gray a binario.Tablas (array)](https://www.youtube.com/watch?v=QibvBFWMqK8)
- [035. Testbench para el sumador genérico de magnitudes. Varias tablas (array). For...loop.](https://www.youtube.com/watch?v=4Gds_AaxYGY)
- [036. Testbench del multiplicador genérico de números enteros de N bits.](https://www.youtube.com/watch?v=OpWwhFyZY0o)
- [037. Testbench para el sumador/restador genérico de números enteros.](https://www.youtube.com/watch?v=pX7X7Tt9hsQ)
- [038. testbench para una memoria ROM que contiene el código Gray de 4 bits.](https://www.youtube.com/watch?v=By6X4QjoSik)
- [039. Testbench del decodificador genérico con habilitación.](https://www.youtube.com/watch?v=4B9F0dc94N4)
- [040. Testbench para el árbol genérico de paridad par e impar.](https://www.youtube.com/watch?v=iVHZ4zucrnI)
- [041. Testbench para la compuerta NOR genérica. For...loop.](https://www.youtube.com/watch?v=9qxchm-y4iQ)
- [042. Testbench para una compuerta NAND genérica. For...loop.](https://www.youtube.com/watch?v=biB3MyJeH6o)
- [043. Testbench de un circuito descripto estructuralmente.](https://www.youtube.com/watch?v=JjbSmiT4E6A)
- [044. Testbench para 4 dígitos de un display de 7 segmentos.](https://www.youtube.com/watch?v=3jSvdBdlBbI)
- [045.1 En este video te cuento cómo va a seguir el curso y por qué voy a pedir donaciones.](https://www.youtube.com/watch?v=LZqBIKGbtf8)
- [045.2 Te cuento porqué no puse el botón de donación.](https://www.youtube.com/watch?v=eLKto4Zeuv0)
- [046. Descripción de un biestable (latch) D.](https://www.youtube.com/watch?v=xbC-0q2V5yg)
- [047. testbench y simulación del latch D.](https://www.youtube.com/watch?v=0Rxob_s_V5U)
- [048. Descripción de un latch SR con reset prioritario.](https://www.youtube.com/watch?v=_lQoqhz5vUk)
- [049. Testbench y simulación de un latch SR con reset prioritario.](https://www.youtube.com/watch?v=z0cJUq3TS5Q)
- [050. Descripción de un flip-flop D activo con flanco ascendente de reloj.](https://www.youtube.com/watch?v=pqc1DWY2Bcc)
- [051. Programa VHDL de simulación para generar serie de pulsos.](https://www.youtube.com/watch?v=KKf9XRLg564)
- [052. Testbench de un flip-flop D. Generación del reloj.](https://www.youtube.com/watch?v=UeQXNQ_ttgk)
- [053. Descripción de un Flip-flop D con clear asincrónico y habilitación del reloj.](https://www.youtube.com/watch?v=Ex52KHUlG3g)
- [054. Testbench y simulación flip-flop D clear y habilitación del clk. Generación de reloj](https://www.youtube.com/watch?v=5lu_mewinzE)
- [054.1. Testbench flip-flop D clear y habilitación del clk. Generación de reloj.](https://www.youtube.com/watch?v=QcbPv_eIXDk)
- [054.2. Simulación flip-flop D, con clear y habilitación del reloj.](https://www.youtube.com/watch?v=qJJEKxJk6q8)
- [055. Descripción de un flip-flop JK.](https://www.youtube.com/watch?v=8Jw4d6JftF4)
- [056.1. Testbench del flip-flop JK.](https://www.youtube.com/watch?v=gMoi87Qal6Q)
- [056.2. Simulación del flip-flop JK.](https://www.youtube.com/watch?v=t3RGq3WX1BA)
- [057. Descripción de un flip-flop JK, con clear y preset.](https://www.youtube.com/watch?v=LucbPc9CPmI)
- [058.1. Testbench del flip-flop JK con clear y preset.](https://www.youtube.com/watch?v=NJwKwR5WbC8)
- [058.2. Simulación flip-flop JK, con clear y preset.](https://www.youtube.com/watch?v=PK5NOug_pw8)
- [059. Comentarios sobre el curso.](https://www.youtube.com/watch?v=PAjigR01dyQ)
- [060. Contador binario, sincrónico, módulo potencia de 2.](https://www.youtube.com/watch?v=YVZXwPfHBTQ)
- [061. Explicación y testbench sobre las limitaciones del contador sin una señal de reset.](https://www.youtube.com/watch?v=dO7Xd0zQK9k)
- [062. Descripción de un contador binario sincrónico, genérico, con reset sincrónico.](https://www.youtube.com/watch?v=OotKk-YmzlA)
- [063. Testbench y simulación del contador sincrónico con reset sincrónico.](https://www.youtube.com/watch?v=hrQ6rDvL5JM)
- [064. Contador binario, habilitación y reset sincrónicos, cuenta terminal y estado.](https://www.youtube.com/watch?v=YxZwHeRQKH8)
- [065. Testbench. Simulación. Metavalue. Cont. hab., reset, estado y cuenta terminal.](https://www.youtube.com/watch?v=ZPbjDdg5a88)
- [066. Contador binario, sincrónico, genérico, bidireccional.](https://www.youtube.com/watch?v=KmKq1LWhZik)
- [067. Testbench y simulación del contador binario, sincrónico, bidireccional.](https://www.youtube.com/watch?v=AjKEE5-9ClQ)
- [068. Contador sincrónico, de módulo arbitrario, ejemplo contador decimal.](https://www.youtube.com/watch?v=EmZdCuSPDhs)
- [069.1. Testbench y simulación del contador sincrónico, módulo M (decimal).](https://www.youtube.com/watch?v=d3O_1zH7MV0)
- [069.2. Análisis de un error de la simulación producido por el testbench del contador M.](https://www.youtube.com/watch?v=igMXofgpO0k)
- [070. Descripción de un registro PIPO, genérico, sincrónico, con reset.](https://www.youtube.com/watch?v=uanfexJVnlg)
- [071. Testbench y simulación del registro PIPO sincrónico con reset sincrónico.](https://www.youtube.com/watch?v=7pvw10f1h_0)
- [072. Registro PIPO, sincrónico, habilitación y salida de alta impedancia.](https://www.youtube.com/watch?v=0hQw5Ce4ox0)
- [073. Testbench y simulación: registro PIPO, sinc. , habilitación y salida tri-state.](https://www.youtube.com/watch?v=3wvh6qtaVPM)
- [074. Descripción de un registro SISO, genérico, de desplazamiento a derecha.](https://www.youtube.com/watch?v=NLS-u4pglXE)
- [074. Descripción: registro SISO/SIPO, genérico, sincrónico, desplazamiento a derecha.](https://www.youtube.com/watch?v=hEUR0Gx_NYU)
- [075. Testbench: registro SISO/SIPO, sincrónico, desplazamiento a derecha.](https://www.youtube.com/watch?v=edDkYZ5OCpM)
- [076. Descripción: registro SISO/SIPO, carga paralelo, sincrónico, genérico, reset.](https://www.youtube.com/watch?v=pZxpQzwzinA)
- [077. Testbench: reg SISO/SIPO, carga paralelo, reset sincrónico.](https://www.youtube.com/watch?v=ESTCW1UjLQw)
- [078. Descripción de un generador de secuencia pseudo-aleatoria de 5 bits.](https://www.youtube.com/watch?v=x4uBn1rdJ5w)
- [079. Testbench y simulación del generador de secuencia pseudo-aleatoria de 5 bits.](https://www.youtube.com/watch?v=-Lx8r5C8NhU)
- [080. Descripción: contador en anillo con arranque automático. Hardware generado.](https://www.youtube.com/watch?v=JZxJRoC9_gY)
- [081. Testbench: contador en anillo con arranque automático.](https://www.youtube.com/watch?v=bKVk_C-NUAU)
- [082. Verificación del funcionamiento del autocorrector del contador en anillo.](https://www.youtube.com/watch?v=OchiJlGkY2c)
- [083. Contador Johnson o Moebius, módulo par, arranque automático. Hardware generado.](https://www.youtube.com/watch?v=egiEn5B4tA8)
- [084. Testbench, contador Johnson o Moebius, módulo par.](https://www.youtube.com/watch?v=srLAj9EmGks)
- [085. Verificación del funcionamiento del autocorrector del contador Johnson o Moebius.](https://www.youtube.com/watch?v=rKqCSOOtPOs)
- [086. Descripción de un contador Johnson o Moebius de módulo impar. Hardware generado.](https://www.youtube.com/watch?v=BNFtPmCvvFM)
- [087. Open Source para editar y simular, ghdl, gtkwave, vs code, git bash.](https://www.youtube.com/watch?v=DA0a3-ixYc0)
- [088. Descripción, testbench y simulación,contador Johnson o Moebius, M impar, autoarranque](https://www.youtube.com/watch?v=mHzDkaGc0h8)
- [089. Máquinas de estado, Mealy, detector de secuencia. Sentencia case.State Machine Viewer](https://www.youtube.com/watch?v=9LJrGNIzJDA)
- [090. Testbench, detector de secuencia, salida Mealy. Simulación con gtkwave, vista estados](https://www.youtube.com/watch?v=z6LYsrG2C4Q)
- [091. Máquina de estado Mealy, detector de secuencia, solapamiento. Case. State Machine.](https://www.youtube.com/watch?v=tzFzxpybQTA)
- [092. Testbench, detector de secuencia, solapamiento, salida Mealy. ModelSim por línea.](https://www.youtube.com/watch?v=NP2FcsOFqEA)
- [093. Máquina de estado Moore, detector de secuencia, sin solapamiento. Case. State Machine](https://www.youtube.com/watch?v=meuYN6zpJMM)
- [094. Testbench, detector de secuencia, sin solapamiento, salida Moore. GTKWave por línea.](https://www.youtube.com/watch?v=BYW6YNFBLQM)
- [095. Máquina de estado Moore, detector de secuencia, con solapamiento. Case. State Machine](https://www.youtube.com/watch?v=6Qh4Mf_4X8E)
- [096. Testbench, detector de secuencia, con solapamiento, salida Moore. GTKWave por línea.](https://www.youtube.com/watch?v=wB53q5iH7r8)
- [097. Problemas cuando la entrada es asincrónica. Máquina Mealy. Detector secuencia 1011.](https://www.youtube.com/watch?v=WAXnRAqwOX8)
- [098. Cómo hacer un archivo ejecutable de comandos para compilar y simular VHDL.](https://www.youtube.com/watch?v=HQJRiRorBCs)
- [099. Máquina de estado. Contador que cuenta en una secuencia. Comparación de estilos.](https://www.youtube.com/watch?v=cFhHs5LAOB4)
- [100. Testbench del contador en secuencia arbitraria. Simulación. Generación de reset.](https://www.youtube.com/watch?v=P6IoXc67_Qs)
- [101. Función de resolución. Aplicación a un multiplexor con salida de alta impedancia.](https://www.youtube.com/watch?v=32hBfaDT5Kk)
- [102. Sumador serie. Casteo y acondicionamiento de operandos.](https://www.youtube.com/watch?v=AK3bnjZYyKM)
- [103. Testbench y simulación del sumador serie. Uso ghdl y gtkwave para simular.](https://www.youtube.com/watch?v=Rbpemc9x2wE)
- [104. Instalación Quartus II, versión 20.1 para Linux.](https://www.youtube.com/watch?v=x3IBDSnN27A)
- [105. Sumador serie, señales detener y fin de suma. Descripción, testbench y simulación.](https://www.youtube.com/watch?v=z-O34pLkwCU)
- [106. Divisor de frecuencia, 2 contadores anidados. Descripción, testbench y simulación.](https://www.youtube.com/watch?v=upjvijcVUNw)
- [107. Estudio del rebote cuando se cuenta en binario usando la plaqueta DE1 de altera.](https://www.youtube.com/watch?v=8JAb2Lzkl4k)
- [108. Descripción: máquina de estado antirrebote (debouce). Ejecución en la plaqueta DE1.](https://www.youtube.com/watch?v=HLe7d2agDqQ)
- [109. En la plaqueta muestro sin &quot;espera_liberación&quot;. Testbench antirrebote y simulación.](https://www.youtube.com/watch?v=ICCKSGzTsiM)
- [110. Descripción, testbench y simulación: sumador serie de los N 1eros. nros. naturales.](https://www.youtube.com/watch?v=HluGz2zQ5eU)
- [111. Testbench que usa archivos para leer los datos y para escribir los resultados.](https://www.youtube.com/watch?v=Ticf5ia-rs8)
- [112. Testbench manejo de archivos, 2da. parte. Poniendo prolijo el archivo de salida.](https://www.youtube.com/watch?v=24gD3Q2TkhI)
- [113. Testbench. Genera archivo de salida de formato compatible con planilla electrónica.](https://www.youtube.com/watch?v=oICeLzY5nYY&feature=youtu.be)
- [114. Utilizando el shell Bash para generar el archivo de entrada al testbench.](https://www.youtube.com/watch?v=7fgOw2_bedk&feature=youtu.be)
- [115. Testbench: archivos con datos de tipo bit_vector, problemas detectados.](https://www.youtube.com/watch?v=ReKqCeJ3Xkw&feature=youtu.be)
- [116. Testbench: que usa archivos y datos string y std_logic_vector. Conversión de datos.](https://www.youtube.com/watch?v=jHhFgJ90Hzo&feature=youtu.be)
- [117. Testbench con una función declarada dentro del código.](https://www.youtube.com/watch?v=wWwfdA3fPEc&feature=youtu.be)
- [118. Declarando una función en  un package y compilando todo con GHDL y con ModelSim.](https://www.youtube.com/watch?v=69mzp_kVM4I&feature=youtu.be)
- [119. Testbench. Uso de procedimientos. Declaración en package. Diferencias con funciones](https://www.youtube.com/watch?v=50LvJMOjhHw&feature=youtu.be)
- [120. Testbench del sumador serie usado para generar la tabla del 7. Graba un archivo.](https://www.youtube.com/watch?v=7a47T0Da4yw&feature=youtu.be)
- [121. Divisor de frecuencia, genera dos frecuencias, 200Hz y 1Hz. Ejecución en plaqueta.](https://www.youtube.com/watch?v=33hjODspUOY&feature=youtu.be)
- [122. 1era.Parte: diseño estructural sincrónico, sumador serie. Ejecución en la plaqueta.](https://www.youtube.com/watch?v=xB50UYudInw&feature=youtu.be)
- [123. Testbench del 1er. bloque del sumador serie. Análisis de la simulación.](https://www.youtube.com/watch?v=EJFYxRDzGOs&feature=youtu.be)
- [124. Descripción como máquina de estado, testbench y simulación de un sumador serie.](https://www.youtube.com/watch?v=xCV512F2HLo&feature=youtu.be)
- [125. Diseño estructural: divisor de frecuencia, antirrebote, sumador serie. Ejecución.](https://www.youtube.com/watch?v=JAD5nL3mIng&feature=youtu.be)
- [126.Diseño estructural, sum.serie, div. frec, antirrebote, conversores bin2BCD, BCD-7seg](https://www.youtube.com/watch?v=6wQs7-2lPW8&feature=youtu.be)
- [127. Descripción de una memoria estática, sincrónica, SRAM. Ejecución en la plaqueta DE1](https://www.youtube.com/watch?v=rpFgFT7pwrc&feature=youtu.be)
- [128. Descripción: memoria estática sincrónica con bus de datos bidireccional, SRAM. DE1.](https://www.youtube.com/watch?v=znC__UqGoog&feature=youtu.be)
- [129. Testbench memoria SRAM estática, sincrónica, bus bidireccional. Usa procedimientos.](https://www.youtube.com/watch?v=emR1UD1Ecsc&feature=youtu.be)
- [130. Simulación de la memoria SRAM estática, sincrónica, con bus bidireccional. Script.](https://www.youtube.com/watch?v=iXZ05uUWfVY&feature=youtu.be)
- [131. Trasmisor de la UART RS-232. Prueba transmitiendo de la plaqueta a la computadora.](https://www.youtube.com/watch?v=yoBSufete8Y&feature=youtu.be)
- [131 Parte final. Transmisor UART RS-232. Uso cable HL-340. Terminal PuTTY.](https://www.youtube.com/watch?v=iPpmXI0MvB4&feature=youtu.be)
- [132.Transmitiendo un mensaje, RS232, desde el circuito sintetizado a la PC. Descripción.](https://www.youtube.com/watch?v=xaXpz2J1Ohk&feature=youtu.be)
- [133. Testbench: transmisor de la UART RS-232 enviando un mensaje. Simulación con GTKWave](https://www.youtube.com/watch?v=tgawRqGUtf8)