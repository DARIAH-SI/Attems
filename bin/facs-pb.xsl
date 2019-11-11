<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- Dodamo xml:id vsem prvim child elementom v div. Potrebno zaradi iskalnika. -->
    <!-- Če ima TEI element atribut xml:id, ga upoštevam pri kreiranju -->
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="lastSIDIHfileNumber">114</xsl:param>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:text">
        <facsimile>
            <xsl:for-each select="//tei:pb">
                <xsl:variable name="letterId" select="ancestor::tei:div[@type='letter']/@xml:id"/>
                <xsl:variable name="fileNumber" select="position() + $lastSIDIHfileNumber"/>
                <xsl:variable name="fileName" select="concat(@facs,'.jpg')"/>
                <xsl:variable name="letterNum" select="tokenize(@facs,'_')[3]"/>
                <xsl:variable name="pageNum" select="number(substring-before(tokenize(@facs,'_')[5],'-'))"/>
                <xsl:variable name="pagePosition" select="tokenize(@facs,'-')[2]"/>
                <graphic xml:id="facs-{$letterNum}-{$pageNum}_{$pagePosition}" corresp="http://hdl.handle.net/20.500.12325/file{$fileNumber}" url="https://sidih.si/iiif/2/entity|1-1000|4|{$fileName}/info.json"/>
            </xsl:for-each>
        </facsimile>
        <text>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </text>
    </xsl:template>
    
    <xsl:template match="tei:pb">
        <xsl:variable name="numLevel">
            <xsl:number count="tei:text//tei:pb" level="any"/>
        </xsl:variable>
        <xsl:variable name="numPB">
            <xsl:number value="$numLevel"/>
        </xsl:variable>
        <xsl:variable name="letterNum" select="tokenize(@facs,'_')[3]"/>
        <xsl:variable name="pageNum" select="number(substring-before(tokenize(@facs,'_')[5],'-'))"/>
        <xsl:variable name="pagePosition" select="tokenize(@facs,'-')[2]"/>
        <pb xml:id="attems-dipl-pb-{$numPB}" facs="#facs-{$letterNum}-{$pageNum}_{$pagePosition}"/>
    </xsl:template>
    
</xsl:stylesheet>