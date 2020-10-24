<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html lang="en">
            <head>
                <title>AZUR Assurances</title>
                <meta charset="utf_8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"/>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"/>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"/>
                <style href="scenario1.css"/>
            </head>
            <body>
                <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
                    <a class="navbar-brand" href="#">AZUR Assurances</a>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Nos services</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Statistiques</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Contrats</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">A propos de nous</a>
                        </li>
                    </ul>
                </nav>
                <div id="demo" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="img/5.jpg" alt="Los Angeles" width="100%" height="100%"/>
                            <div class="carousel-caption d-none d-md-block">
                                <h1 style="color:#494846; font-family: Century Gothic, sans-serif;">AZUR Assurances</h1>
                                <p style="color:#494846; font-family: Century Gothic, sans-serif;">L'assurance qui veille sur vous, toujours prêt de vous !!!</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <div style="margin:5%; text-align:center; ">
                        <h1 class="display-4" style="color:#0dd05a">Statistiques</h1>
                        <p class="lead">Avec AZUR Assurances, vous avez la possibilité de profiter de plusieurs types d'assurances notamment : </p>
                        <hr class="my-4 dark"/>
                    </div>


                    <div class="container">
                        <xsl:apply-templates select="Assurances/Type"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="Type">
        <xsl:variable name="ID" select="@IdType"/>
        <div>
            <div>
                <h4 style="color:#0dd05a;"> <xsl:value-of select="Intitule"/></h4>
                <hr style="border-color:#0dd05a"/>
                <p> <xsl:value-of select="Description"/>
                    <br/><br/>

                    <ol>
                        <xsl:apply-templates select="../Assurance[@Type = $ID]"/>
                    </ol>

                </p>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="Assurance">
        <xsl:if test="Genre/text()">
            <b> <li> <xsl:value-of select="Genre"/> </li></b>
        </xsl:if>
        <span style="color:#0dd05a;"> <b> Options : </b>   </span>
        <xsl:apply-templates select="Options/Option"/>
    </xsl:template>

    <xsl:template match="Option">
        <hr class="my-4 dark"/>
        <span><b>Quoi ? :</b> <xsl:value-of select="Intitule"/></span> <br/>
        <span><b>Comment ? :</b> <xsl:value-of select="Description"/></span> <br/>
        <span><b>Les Risques :</b> <xsl:apply-templates select="Risques"/></span> <br/>
    </xsl:template>

    <xsl:template match="Risques">
        <xsl:choose>
            <xsl:when test="Risque/text()">
                <ul>
                    <xsl:for-each select="Risque">
                        <li> <xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <span> Pas de Risques (Un peu bête OUI)</span>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>





</xsl:stylesheet>
