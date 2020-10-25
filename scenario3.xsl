<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">

    <xsl:import href="date.xsl"/>
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
                            <a class="nav-link" href="#">Chiffre d'affaire</a>
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
                        <h1 class="display-4" style="color:#0dd05a">Chiffre d'affaire </h1>
                        <p class="lead">Details sur les contrats </p>
                        <hr class="my-4 dark"/>
                    </div>


                    <div class="container">
                        <xsl:apply-templates select="Assurances"/>
                        <h2 style="text-align:center"> Les Détails : </h2>
                        <xsl:apply-templates select="Assurances/Contrat"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="Assurances">
        <xsl:variable name="somme">
            <xsl:call-template name="Somme">
                <xsl:with-param name="listeContrats" select="Contrat"/>

            </xsl:call-template>
        </xsl:variable>

        <h2 style="text-align:center"> <i>Chiffre d'affaire : <xsl:value-of select="$somme"/> EUR </i></h2>
    </xsl:template>

    <xsl:template match="Contrat">
        <xsl:variable name="AssuranceID" select="AssuranceRef/@id"/>
        <xsl:variable name="TypeID" select="../Assurance[@IdAss = $AssuranceID]/@Type"/>
        <xsl:variable name="OptionID" select="AssuranceRef/@option"/>
        <xsl:variable name="ClientID" select="ClientRef/@id"/>
        <xsl:variable name="PrixDuContrat" select="../Assurance[@IdAss = $AssuranceID]/Options/Option[@num = $OptionID]/Prix"/>
        <div>
            <div>
                <h4 style="color:#0dd05a;"> Contrat  <xsl:value-of select="position()"/> -> Prix : <xsl:value-of
                        select="$PrixDuContrat"/> EUR </h4>
                <p>
                    <b>Assurance : </b> <xsl:value-of select="../Type[@IdType = $TypeID]/Intitule"/>
                    <b> | Option : </b> <xsl:value-of select="../Assurance[@IdAss = $AssuranceID]/Options/Option[@num = $OptionID]/Intitule"/>
                    <b> | Client : </b> <xsl:value-of select="../Client[@IdClient = $ClientID]/Nom"/>  <xsl:value-of select="../Client[@IdClient = $ClientID]/Prenom"/> (<xsl:value-of select="../Client[@IdClient = $ClientID]/Email"/>)
                </p>
                <hr style="border-color:#0dd05a"/>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="PrixOfContrat">
        <xsl:param name="Contrat"/>
        <xsl:variable name="AssuranceID" select="$Contrat/AssuranceRef/@id"/>
        <xsl:variable name="OptionID" select="$Contrat/AssuranceRef/@option"/>
        <xsl:variable name="PrixDuContrat" select="Assurance[@IdAss = $AssuranceID]/Options/Option[@num = $OptionID]/Prix"/>
        <xsl:value-of select="$PrixDuContrat"/>
    </xsl:template>




    <xsl:template name="Somme">
        <xsl:param name="listeContrats"/>
        <xsl:choose>
            <xsl:when test="$listeContrats">
                <xsl:variable name="ContratActu" select="$listeContrats[1]"/>
                <xsl:variable name="PrixContratActu">
                    <xsl:call-template name="PrixOfContrat">
                        <xsl:with-param name="Contrat" select="$ContratActu"/>

                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="autresContrats">
                    <xsl:call-template name="Somme">
                        <xsl:with-param name="listeContrats" select="$listeContrats[position() != 1]"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:value-of select="$PrixContratActu+$autresContrats"/>
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
