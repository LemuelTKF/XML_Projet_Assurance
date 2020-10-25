<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">
    <xsl:template match="/">
       <CLIENTS>
           <xsl:apply-templates select="Assurances/Contrat"/>
       </CLIENTS>
    </xsl:template>

    <xsl:template match="Contrat">
        <xsl:if test="DateSigned/text()">
        <xsl:variable name="ClientID" select="ClientRef/@id"/>
        <CLIENT>
            <NOM><xsl:value-of select="../Client[@IdClient = $ClientID]/Nom"/></NOM>
            <PRENOM><xsl:value-of select="../Client[@IdClient = $ClientID]/Prenom"/></PRENOM>
            <EMAIL><xsl:value-of select="../Client[@IdClient = $ClientID]/Email"/></EMAIL>
            <ANNEENAISSANCE><xsl:value-of select="../Client[@IdClient = $ClientID]/DateNaiss"/></ANNEENAISSANCE>
        </CLIENT>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
