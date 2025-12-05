<?xml version="1.0" encoding="UTF-8"?>
<!--   
    Autor: Saioa Echevarria Ballesteros 
    Fecha: 05/12/2025  
    Módulo: LMSGI  
    UD: 4 – Tarea Evaluativa 2
    Descripción: XSLT para transformar el XML de Plantas del Jardín Botánico en una tabla HTML
-->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- =====================================
         Plantilla raíz
         - Se aplica al nodo raíz (/)
         - Genera la estructura HTML completa
         - Incluye head, body, header, main y footer
    ===================================== -->
    <xsl:template match="/">
        <html>
            <head>
                <link href="./css/estilo.css" rel="stylesheet" type="text/css" />
                <meta charset="utf-8"/>
                <title>Plantas</title>
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
                     Main: sección principal de plantas
                     - Se genera un <article> por cada planta
                ===================================== -->
                <main id="jardinbotanico">
                    <h1>PLANTAS</h1>
                    <xsl:apply-templates select="jardinBotanico/plantas/planta"/>
                </main>

                <!-- Footer con copyright y contacto-->
                <footer>
                    <address>&#169; Desarrollado por info@birt.eus</address>
                </footer>
            </body>
        </html>
    </xsl:template>

    <!-- =====================================
         Plantilla para cada planta
         - Genera un artículo (<article>) con clase "articulo"
         - Contiene:
           * Imagen de la planta
           * Icono de luminosidad alta si corresponde
           * Nombre común como enlace a Wikipedia (familia de la planta)
           * Luminosidad de la planta
    ===================================== -->
    <xsl:template match="planta">
        <article class="articulo">
            <img class="imagen" src="./img/{@foto}" />
            
            <!-- =====================================
                 - Solo se muestra si luminosidad='Alta'
            ===================================== -->
            <xsl:if test="luminosidad='Alta'">
                <img class="alta-icono" src="./img/Alta.png"/>
            </xsl:if>

            <h2>
                <a target="_blank" href="https://es.wikipedia.org/wiki/{@familia}">
                    <xsl:value-of select="nombreComun"/>
                </a>
            </h2>

            <h3><xsl:value-of select="luminosidad"/></h3>
        </article>
    </xsl:template>

</xsl:stylesheet>
