<?xml version="1.0" encoding="UTF-8"?>
<!--   
    Autor: Saioa Echevarria Ballesteros 
    Fecha: 05/12/2025  
    Módulo: LMSGI  
    UD: 4 – Tarea Evaluativa 2
    Descripción: XSLT para transformar el XML de Actividades del Jardín Botánico en una tabla HTML
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- =====================================
         Variable global
         - "mes" almacena el número del mes que se quiere mostrar
         - En este ejemplo, el mes es 11 (noviembre)
    ===================================== -->
    <xsl:variable name="mes">11</xsl:variable>

    <!-- =====================================
         Plantilla raíz
         - Aplica a todo el documento (/)
         - Genera la estructura HTML principal
         - Incluye head, body, header, main y footer
    ===================================== -->
    <xsl:template match="/">
        <html>
            <head>
                <link href="./css/estilo.css" rel="stylesheet" type="text/css" />
                <meta charset="utf-8"/>
                <title>Actividades</title>
            </head>

            <body>
                <!-- =====================================
                     Header con logo y menú de navegación
                     - Enlaces a las secciones Zonas, Plantas y Actividades
                ===================================== -->
                <header>
                    <img src="./img/logotipo.png" alt="Reservas"/>
                    <a href="zonas.html">Zonas</a>
                    <a href="plantas.html">Plantas</a>
                    <a href="actividades.html">Actividades</a>
                </header>

                <!-- =====================================
                     Main: muestra las actividades del mes
                     - Se filtran las actividades cuyo mes de fechaHora coincide con $mes
                     - Se ordenan por fechaHora descendente
                ===================================== -->
                <main>
                    <h1>Actividades del mes <xsl:value-of select="$mes"/></h1>

                    <xsl:apply-templates 
                        select="jardinBotanico/actividades/actividad
                                [substring(fechaHora,6,2) = $mes]">
                        <xsl:sort select="fechaHora" order="descending"/>
                    </xsl:apply-templates>
                </main>

                <!-- Footer con copyright y contacto -->
                <footer>
                    <address>&#169; Desarrollado por info@birt.eus</address>
                </footer>
            </body>
        </html>
    </xsl:template>

    <!-- =====================================
         Plantilla para cada actividad
         - Genera un artículo (<article>) por actividad
    ===================================== -->
    <xsl:template match="actividad">
        <article class="actividades">

            <h4>
                <xsl:value-of select="titulo"/> - 
                <xsl:value-of select="count(responsables/responsable)"/> Responsables
            </h4>

            <h2>Fecha: 
                <xsl:value-of select="substring(fechaHora,1,10)"/>
            </h2>

            <h2>Hora: 
                <xsl:value-of select="substring(fechaHora,12,5)"/>
            </h2>

            <h2>Lugar: <xsl:value-of select="@sala"/></h2>

            <!-- Lista de responsables -->
            <ul>
                <xsl:apply-templates select="responsables/responsable"/>
            </ul>
        </article>
    </xsl:template>

    <!-- =====================================
         Plantilla para cada responsable
         - Muestra el nombre y correo electrónico
    ===================================== -->
    <xsl:template match="responsable">
        <li>
            <xsl:value-of select="nomresponsable"/> -
            <xsl:value-of select="email"/>
        </li>
    </xsl:template>

</xsl:stylesheet>
