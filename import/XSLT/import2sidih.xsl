<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:METS="http://www.loc.gov/METS/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- izhodiščni je files-list.xml -->
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:param name="lastSIDIHfileNumber">114</xsl:param>
    <xsl:param name="path2entity">import/facsimile/sidih/menuTop/menu1/menu4/3/4/</xsl:param>
    
    <xsl:template match="tei:TEI/tei:text/tei:body">
        <xsl:for-each select="//tei:pb">
            <xsl:variable name="letterId" select="ancestor::tei:div[@type='letter']/@xml:id"/>
            <xsl:variable name="fileNumber" select="position() + $lastSIDIHfileNumber"/>
            <xsl:variable name="document" select="concat($path2entity,'file',$fileNumber,'/mets.xml')"/>
            <xsl:variable name="fileName" select="concat(@facs,'.jpg')"/>
            <xsl:variable name="letterNum" select="number(tokenize(@facs,'_')[3])"/>
            <xsl:variable name="pageNum" select="number(substring-before(tokenize(@facs,'_')[5],'-'))"/>
            <xsl:variable name="pagePosition" select="tokenize(@facs,'-')[2]"/>
            <xsl:variable name="place" select="ancestor::tei:TEI/tei:teiHeader/tei:profileDesc/tei:correspDesc[@corresp = concat('#',$letterId)]/tei:correspAction/tei:settlement"/>
            <xsl:variable name="date" select="ancestor::tei:TEI/tei:teiHeader/tei:profileDesc/tei:correspDesc[@corresp = concat('#',$letterId)]/tei:correspAction/tei:date"/>
            <xsl:result-document href="{$document}">
                <METS:mets xmlns:METS="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/TR/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    TYPE="file" ID="si4.file{$fileNumber}" OBJID="http://hdl.handle.net/20.500.12325/file{$fileNumber}">
                    <METS:metsHdr CREATEDATE="{current-dateTime()}" LASTMODDATE="" RECORDSTATUS="Active">
                        <METS:agent ROLE="DISSEMINATOR" TYPE="ORGANIZATION">
                            <METS:name>Sidih</METS:name>
                            <METS:note>https://sidih.si</METS:note>
                        </METS:agent>
                        <METS:agent ROLE="CREATOR" ID="3" TYPE="INDIVIDUAL">
                            <METS:name>Pančur, Andrej</METS:name>
                        </METS:agent>
                    </METS:metsHdr>
                    <METS:dmdSec ID="description">
                        <METS:mdWrap MDTYPE="DC">
                            <METS:xmlData xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/">
                                <dc:title xml:lang="eng">
                                    <xsl:value-of select="concat($place,', ',$date,', ',$pageNum,' ',if ($pagePosition = 're') then 'recto' else 'verso')"/>
                                </dc:title>
                            </METS:xmlData>
                        </METS:mdWrap>
                    </METS:dmdSec>
                    <METS:amdSec ID="amd">
                        <METS:techMD ID="tech.premis">
                            <METS:mdWrap MDTYPE="PREMIS:OBJECT" MIMETYPE="text/xml">
                                <METS:xmlData xmlns:premis="http://www.loc.gov/premis/v3">
                                    <premis:objectIdentifier>
                                        <premis:objectIdentifierType>si4</premis:objectIdentifierType>
                                        <premis:objectIdentifierValue></premis:objectIdentifierValue>
                                    </premis:objectIdentifier>
                                    <premis:objectIdentifier>
                                        <premis:objectIdentifierType>Local name</premis:objectIdentifierType>
                                        <premis:objectIdentifierValue></premis:objectIdentifierValue>
                                    </premis:objectIdentifier>
                                    <premis:objectIdentifier>
                                        <premis:objectIdentifierType>hdl</premis:objectIdentifierType>
                                        <premis:objectIdentifierValue></premis:objectIdentifierValue>
                                    </premis:objectIdentifier>
                                    <premis:objectCategory>File</premis:objectCategory>
                                </METS:xmlData>
                            </METS:mdWrap>
                        </METS:techMD>
                        <METS:techMD ID="tech.si4">
                            <METS:mdWrap MDTYPE="OTHER" OTHERMDTYPE="SI4" MIMETYPE="text/xml">
                                <METS:xmlData xmlns:si4="http://si4.si/schema/">
                                    <si4:additionalMetadata>false</si4:additionalMetadata>
                                </METS:xmlData>
                            </METS:mdWrap>
                        </METS:techMD>
                    </METS:amdSec>
                    <METS:fileSec xmlns:xlink="http://www.w3.org/1999/xlink" ID="files">
                        <!-- System will manage this section when you save -->
                        <METS:fileGrp USE="DEFAULT">
                            <METS:file ID="file{$fileNumber}" OWNERID="{$fileName}" USE="DEFAULT" CREATED="" SIZE="" CHECKSUM="" CHECKSUMTYPE="" MIMETYPE="image/jpeg">
                                <METS:FLocat ID="file{$fileNumber}" USE="HTTP" LOCTYPE="URL" title="{$fileName}" href="http://hdl.handle.net/20.500.12325/file{$fileNumber}"/>
                            </METS:file>
                        </METS:fileGrp>
                    </METS:fileSec>
                    <METS:structMap xmlns:xlink="http://www.w3.org/1999/xlink" ID="structure" TYPE="primary">
                        <!-- System will manage this section when you save -->
                    </METS:structMap>
                    <METS:behaviorSec xmlns:xlink="http://www.w3.org/1999/xlink" ID="si4.behavior">
                        <METS:behavior BTYPE="default">
                            <METS:mechanism LOCTYPE="URL" xlink:href="/xsd/dcterms"/>
                        </METS:behavior>
                    </METS:behaviorSec>
                </METS:mets>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>