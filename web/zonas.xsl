<?xml version="1.0" encoding="UTF-8"?>
<!--   
    Autor: Saioa Echevarria Ballesteros 
    Fecha: 05/12/2025  
    Módulo: LMSGI  
    UD: 4 – Tarea Evaluativa 2
    Descripción: XSLT para transformar el XML de Zonas del Jardín Botánico en una tabla HTML
    Se mostrará solo el nombre, la ubicación y el horario de apertura de las zonas
    cuyo horario de apertura sea anterior o igual a las 10:00.
-->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- =====================================
         Plantilla raíz
         Coincide con la raíz del XML (/) y genera la estructura HTML
    ===================================== -->
    <xsl:template match="/">
        <html>
            <head>
                <!-- Enlace a la hoja de estilos compartida -->
                <link href="./css/estilo.css" rel="stylesheet" type="text/css"/>
                <meta charset="utf-8"/>
                <title>Zonas</title>
            </head>
            <body>
                <!-- =====================================
                     HEADER
                     Contiene el logotipo y el menú de navegación
                ===================================== -->
                <header>
                    <img src="./img/logotipo.png" alt="Reservas"/>
                    <a href="zonas.html">Zonas</a>
                    <a href="plantas.html">Plantas</a>
                    <a href="actividades.html">Actividades</a>
                </header>

                <!-- =====================================
                     MAIN
                     Contiene la tabla con la información de las zonas
                ===================================== -->
                <main>
                    <h1>ZONAS</h1>
                    <table>
                        <tr>
                            <th>ZONA</th>
                            <th>Ubicación</th>
                            <th>Horario</th>
                        </tr>

                        <!-- =====================================
                             Se aplica la plantilla "zona" solo a las zonas cuyo horario de apertura <= 10:00
                        ===================================== -->
                        <xsl:apply-templates select="jardinBotanico/zonas/zona[number(translate(normalize-space(horarioapertura), ':', '')) &lt;= 1000]"/>
                    </table>
                </main>

                <!-- =====================================
                     FOOTER
                     Información de contacto y créditos
                ===================================== -->
                <footer>
                    <address>© Desarrollado por info@birt.eus</address>
                </footer>
            </body>
        </html>
    </xsl:template>

    <!-- =====================================
         Plantilla para cada zona
    ===================================== -->
    <xsl:template match="zona">
        <tr>
            <!-- Nombre de la zona -->
            <td><xsl:value-of select="nombre"/></td>

            <!-- Ubicación -->
            <td>
                <xsl:choose>
                    <!-- Si la ubicación contiene "Exterior", se pinta en azul -->
                    <xsl:when test="contains(ubicacion, 'Exterior')">
                        <span class="azul"><xsl:value-of select="ubicacion"/></span>
                    </xsl:when>
                    <!-- En caso contrario, se muestra normal -->
                    <xsl:otherwise>
                        <xsl:value-of select="ubicacion"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

            <!-- Horario: apertura - cierre -->
            <td>
                <xsl:value-of select="horarioapertura"/> - <xsl:value-of select="horariocierre"/>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
