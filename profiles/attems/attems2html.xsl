<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="tei html teidocx xs" version="2.0">

    <xsl:import href="../../../../pub-XSLT/Stylesheets/html5-foundation6-chs/to.xsl"/>

    <xsl:import href="text-critical.xsl"/>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
        <desc>
            <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6
                http://foundation.zurb.com/sites/docs/).</p>
            <p>This software is dual-licensed: 1. Distributed under a Creative Commons
                Attribution-ShareAlike 3.0 Unported License
                http://creativecommons.org/licenses/by-sa/3.0/ 2.
                http://www.opensource.org/licenses/BSD-2-Clause Redistribution and use in source and
                binary forms, with or without modification, are permitted provided that the
                following conditions are met: * Redistributions of source code must retain the above
                copyright notice, this list of conditions and the following disclaimer. *
                Redistributions in binary form must reproduce the above copyright notice, this list
                of conditions and the following disclaimer in the documentation and/or other
                materials provided with the distribution. This software is provided by the copyright
                holders and contributors "as is" and any express or implied warranties, including,
                but not limited to, the implied warranties of merchantability and fitness for a
                particular purpose are disclaimed. In no event shall the copyright holder or
                contributors be liable for any direct, indirect, incidental, special, exemplary, or
                consequential damages (including, but not limited to, procurement of substitute
                goods or services; loss of use, data, or profits; or business interruption) however
                caused and on any theory of liability, whether in contract, strict liability, or
                tort (including negligence or otherwise) arising in any way out of the use of this
                software, even if advised of the possibility of such damage. </p>
            <p>Andrej Pančur, Institute for Contemporary History</p>
            <p>Copyright: 2013, TEI Consortium</p>
        </desc>
    </doc>

    <xsl:param name="localWebsite">true</xsl:param>

    <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->

    <!--<xsl:param name="path-general">../../../</xsl:param>-->
    <!--<xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>-->
    <!-- v primeru localWebsite='true' spodnji paragraf nima vrednosti -->
    <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>

    <!-- Andrej: moja absolutna pot v outputDir je /Users/andrejp/Repo/pub/Kapelski/sidih/,
         vendar v tem primeru naredi pretvorbro iz generiranega sidih/kapelski.xml kar direktno v sidih/ direktorij -->
    <xsl:param name="outputDir">docs/</xsl:param>

    <xsl:param name="title-bar-sticky">false</xsl:param>

    <xsl:param name="documentationLanguage">en</xsl:param>
    <xsl:param name="element-gloss-teiHeader-lang">en</xsl:param>


    <xsl:param name="homeLabel">eZMono</xsl:param>
    <xsl:param name="homeURL">http://hdl.handle.net/20.500.12325/3</xsl:param>

    <!-- V html/head izpisani metapodatki -->
    <xsl:param name="description"/>
    <xsl:param name="keywords"/>
    <xsl:param name="title"/>


    <!-- Slovene localisation of eZRC/TEI element, attribute and value names / glosses to Slovene -->
    <!-- Needed for teiHeader localisation and write-out of e.g. Janus elements -->
    <xsl:param name="localisation-file">../teiLocalise-sl.xml</xsl:param>
    <xsl:key name="id" match="tei:*" use="@xml:id"/>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
        <param name="thisLanguage"/>
    </doc>
    <xsl:template name="nav-body-head">
        <xsl:param name="thisLanguage"/>
        <xsl:text>Letters</xsl:text>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Ne procesiram štetja besed v kolofonu</desc>
    </doc>
    <xsl:template name="countWords"/>

    <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
        <xsldoc:desc>V css in javascript Hook dodam viewerjs</xsldoc:desc>
    </xsldoc:doc>
    <xsl:template name="cssHook">
        <xsl:if test="$title-bar-sticky = 'true'">
            <xsl:value-of
                select="concat($path-general, 'themes/css/foundation/6/sistory-sticky_title_bar.css')"
            />
        </xsl:if>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css"
            rel="stylesheet" type="text/css"/>
        <link
            href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}"
            rel="stylesheet" type="text/css"/>
        <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"
            rel="stylesheet" type="text/css"/>
        <!-- dodan viewerjs -->
        <link href="{concat($path-general,'themes/plugin/viewerjs/1.2.0/dist/viewer.css')}"
            rel="stylesheet" type="text/css"/>
        <!-- dodam projektno specifičen css, ki se nahaja v istem direktoriju kot ostali HTML dokumenti -->
        <link href="project.css" rel="stylesheet" type="text/css"/>
    </xsl:template>
    <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
        <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
    </xsldoc:doc>
    <xsl:template name="javascriptHook">
        <script src="{concat($path-general,'themes/foundation/6/js/vendor/jquery.js')}"/>
        <!-- za highcharts -->
        <xsl:if
            test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
            <xsl:variable name="jsfile"
                select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
            <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
            <script src="{$chart-jsfile[1]}"/>
        </xsl:if>
        <!-- za back-to-top in highcharts je drugače potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je že vsebovana zgoraj -->
        <!-- dodan viewerjs -->
        <script src="{concat($path-general,'themes/plugin/viewerjs/1.2.0/dist/viewer.js')}"/>
        <!-- dodan css jstree (mora biti za jquery.js -->
        <link
            href="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/themes/default/style.min.css')}"
            rel="stylesheet" type="text/css"/>
        <!-- dodan jstree -->
        <script src="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/jstree.min.js')}"/>
    </xsl:template>


    <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
        <xsldoc:desc>Dodam javascript za viewerjs (pogled tei:pb)</xsldoc:desc>
    </xsldoc:doc>
    <xsl:template name="bodyEndHook">
        <script type="text/javascript">
           var allImages = document.getElementsByClassName('image');
           
           var image = Array.prototype.filter.call(allImages, function(element){
               var viewer = new Viewer(element, {
                   url: 'data-original',
                   toolbar: false,
                   navbar: false,
                   title: false,
                   backdrop: true
                });
              });
       </script>

        <script src="{concat($path-general,'themes/foundation/6/js/vendor/what-input.js')}"/>
        <script src="{concat($path-general,'themes/foundation/6/js/vendor/foundation.min.js')}"/>
        <script src="{concat($path-general,'themes/foundation/6/js/app.js')}"/>
        <!-- back-to-top -->
        <script src="{concat($path-general,'themes/js/plugin/back-to-top/back-to-top.js')}"/>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Prelome strani izkoristim za povezave na dinamično stran para.html</desc>
    </doc>
    <xsl:template match="tei:pb">
        <xsl:variable name="facs-id" select="substring-after(@facs, '#')"/>

        <xsl:variable name="image"
            select="substring-before(ancestor::tei:TEI/tei:facsimile/tei:graphic[@xml:id = $facs-id]/@url, '/info.json')"/>
        <xsl:variable name="image-thumb-iiif" select="concat($image, '/full/,200/0/default.jpg')"/>
        <xsl:variable name="image-small-iiif" select="concat($image, '/full/,600/0/default.jpg')"/>
        <xsl:variable name="image-large-iiif" select="concat($image, '/full/,1200/0/default.jpg')"/>
        <hr/>
        <div class="border-content pb" id="{@xml:id}">
            <div class="show-for-large">
                <img class="image" data-original="{$image-large-iiif}" src="{$image-small-iiif}"/>
            </div>
            <div class="show-for-medium-only">
                <img class="image" data-original="{$image-large-iiif}" src="{$image-thumb-iiif}"/>
            </div>
        </div>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc/>
    </doc>
    <xsl:template match="tei:fw">
        <div class="pageNum" style="text-align: center;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc/>
    </doc>
    <xsl:template match="tei:label">
        <div class="{if (@rend) then (concat('text',@rend)) else 'padding'}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- poenostavljeno procesiranje besed, ločil in presledkov -->
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc/>
    </doc>
    <xsl:template match="tei:w">
        <xsl:apply-templates/>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc/>
    </doc>
    <xsl:template match="tei:pc">
        <xsl:value-of select="."/>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc/>
    </doc>
    <xsl:template match="tei:c">
        <xsl:text> </xsl:text>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Odstranim prvotno procesiranje app elementov v opombah</desc>
    </doc>
    <xsl:template match="tei:app" mode="printnotes">
        <!--<xsl:variable name="identifier">
         <xsl:text>App</xsl:text>
         <xsl:choose>
            <xsl:when test="@xml:id">
               <xsl:value-of select="@xml:id"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:number count="tei:app" level="any"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <div class="app">
         <xsl:call-template name="makeAnchor">
            <xsl:with-param name="name" select="$identifier"/>
         </xsl:call-template>
         <span class="lemma">
            <xsl:call-template name="appLemma"/>
         </span>
         <xsl:text>] </xsl:text>
         <span class="lemmawitness">
            <xsl:call-template name="appLemmaWitness"/>
         </span>
         <xsl:call-template name="appReadings"/>
      </div>-->
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Pri app procesiram samo lemo. Vsebino elementov rdg procesiram pri vzporednem
            prikazu.</desc>
    </doc>
    <xsl:template match="tei:app">
        <xsl:apply-templates/>
    </xsl:template>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Lemo procesiram</desc>
    </doc>
    <xsl:template match="tei:lem">
        <xsl:apply-templates/>
    </xsl:template>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>rdg odstranim</desc>
    </doc>
    <xsl:template match="tei:rdg">
        <!-- ne procesiram naprej -->
    </xsl:template>

    <!-- od tukaj naprej dodam za novo procesiranje kolofona in naslovnice: po zgledu na e-MAMS -->
    <xsl:param name="images_on_titlepage">
        <p>IMAGES ON THE COVER PAGE:<br/> Portrait of Count Ignaz Maria von Attems (1714–1762) painted
            by Adriaen Carpentiers, dated in Rome 1738. (Universalmuseum Joanneum, Inv. Nr. Eg897;
            by kind permission)<br/> Portrait of Count Franz Dismas von Attems (1691–1750) painted
            by Josef Digl in 1738. (Pokrajinski muzej Ptuj Ormož, 240 x 167 cm, inv. no. G 1100 S,
            ©2015 Marjan Laznik; by kind permission)<br/> Part of the letter from dated in Würzburg
            on 15 December 1734, Steiermärkische Landesarchiv, Familienarchiv Attems, Briefe des
            Grafen Ignaz Attems, K. 19, H. 87; by kind permission).</p>
        <p>The cover page is designed by Žiga Okorn (Uvid.si d.o.o.).</p>
    </xsl:param>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Za publicationStmt dodam procesiranje authority</desc>
    </doc>
    <xsl:template match="tei:publicationStmt" mode="kolofon">
        <!-- dodan authority -->
        <xsl:apply-templates select="tei:authority" mode="kolofon"/>
        <xsl:apply-templates select="tei:publisher" mode="kolofon"/>
        <xsl:apply-templates select="tei:date" mode="kolofon"/>
        <xsl:apply-templates select="tei:pubPlace" mode="kolofon"/>
        <xsl:apply-templates select="tei:availability" mode="kolofon"/>
        <xsl:apply-templates select="tei:idno" mode="kolofon"/>
    
        <!-- dodam še podatke za slike na naslovnici -->
        <xsl:copy-of select="$images_on_titlepage"/>
        <br/>
        <br/>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Dodatno procesiranje identifikatorjev</desc>
    </doc>
    <xsl:template match="tei:idno" mode="kolofon">
        <p>
            <xsl:choose>
                <xsl:when test="matches(., 'https?://')">
                    <a href="{.}" target="_blank">
                        <xsl:value-of select="."/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(@type, ': ', .)"/>
                </xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Dodal oznako </desc>
    </doc>
    <xsl:template match="tei:publisher" mode="kolofon">
        <p itemprop="publisher">
            <xsl:text>Published by: </xsl:text>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>dodano procesiranje authority</desc>
    </doc>
    <xsl:template match="tei:authority" mode="kolofon">
        <p itemprop="authority">
            <xsl:text>Issued by: </xsl:text>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Sprememba pri procesiranju naslova</desc>
    </doc>
    <xsl:template match="tei:titleStmt" mode="kolofon">
        <!-- avtor -->
        <!--<p>
            <xsl:for-each select="tei:author">
                <span itemprop="author">
                    <xsl:choose>
                        <xsl:when test="tei:forename or tei:surname">
                            <xsl:for-each select="tei:forename">
                                <xsl:value-of select="."/>
                                <xsl:if test="position() ne last()">
                                    <xsl:text> </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:if test="tei:surname">
                                <xsl:text> </xsl:text>
                            </xsl:if>
                            <xsl:for-each select="tei:surname">
                                <xsl:value-of select="."/>
                                <xsl:if test="position() ne last()">
                                    <xsl:text> </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
                <xsl:if test="position() != last()">
                    <br/>
                </xsl:if>
            </xsl:for-each>
        </p>-->
        <!-- Naslov mora vedno biti, zato ne preverjam, če obstaja. -->
        <!-- spremenil procesiranje naslova, tako da je vse v bold, za druge naslove pa se predpostavlja, da so angleški, zato so ločeni z / -->
        <p itemprop="name" style="font-size: 1.6em; font-weight: bold;">
            <xsl:for-each select="tei:title">
                <xsl:value-of select="."/>
                <xsl:if test="position() != last()">
                    <xsl:if test="position() != last()">
                        <xsl:text> / </xsl:text>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
        </p>
        <br/>
        <br/>
        <xsl:apply-templates select="tei:respStmt" mode="kolofon"/>
        <br/>
        <xsl:if test="tei:funder">
            <p>
                <xsl:text>Acknowledgements:</xsl:text>
                <br/>
                <xsl:for-each select="tei:funder">
                    <xsl:value-of select="."/>
                    <br/>
                </xsl:for-each>
            </p>
        </xsl:if>
        <br/>
    </xsl:template>

    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>dodatki pri procesiranju naslovne strani</desc>
    </doc>
    <xsl:template match="tei:titlePage">
        <!-- avtor -->
        <p class="naslovnicaAvtor">
            <xsl:for-each select="tei:docAuthor">
                <xsl:choose>
                    <xsl:when test="tei:forename or tei:surname">
                        <xsl:for-each select="tei:forename">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() ne last()">
                                <xsl:text> </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:if test="tei:surname">
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:for-each select="tei:surname">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() ne last()">
                                <xsl:text> </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="position() ne last()">
                    <br/>
                </xsl:if>
            </xsl:for-each>
        </p>
        <!-- naslov -->
        <!-- dodam, da vse naslove in podnaslove prikaže enako (ne pa samo prvega)[1] -->
        <xsl:for-each select="tei:docTitle/tei:titlePart">
            <h1 class="text-center">
                <xsl:value-of select="."/>
            </h1>
            <!--<xsl:for-each select="following-sibling::tei:titlePart">
            <h1 class="subheader podnaslov"><xsl:value-of select="."/></h1>
         </xsl:for-each>-->
        </xsl:for-each>
        <!-- dodam za byline -->
        <xsl:for-each select="tei:byline">
            <p class="naslovnicaAvtor">
                <xsl:value-of select="."/>
            </p>
        </xsl:for-each>
        <!-- dodam za docEdition -->
        <xsl:if test="tei:docEdition">
            <div class="text-center">
                <p>
                    <xsl:value-of select="tei:docEdition"/>
                </p>
            </div>
        </xsl:if>
        <!-- dodam za zbirko -->
        <xsl:for-each select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc/tei:seriesStmt">
            <div class="text-center">
                <xsl:value-of select="tei:title"/>
                <xsl:if test="tei:biblScope[@unit = 'volume']">
                    <xsl:value-of select="concat(' ', tei:biblScope[@unit = 'volume'])"/>
                </xsl:if>
            </div>
        </xsl:for-each>
        <br/>
        <xsl:if test="tei:figure">
            <div class="text-center">
                <p>
                    <!-- dodam višimo slike -->
                    <img src="{tei:figure/tei:graphic/@url}" alt="naslovna slika"
                        style="height:700px;" onclick="alert('Portrait of Count Ignaz Maria von Attems (1714–1762) painted by Adriaen Carpentiers, dated in Rome 1738. (Universalmuseum Joanneum, Inv. Nr. Eg897; by kind permission)\nPortrait of Count Franz Dismas von Attems (1691–1750) painted by Josef Digl in 1738. (Pokrajinski muzej Ptuj Ormož, 240 x 167 cm, inv. no. G 1100 S, ©2015 Marjan Laznik; by kind permission)\nPart of the letter from dated in Würzburg on 15 December 1734, Steiermärkische Landesarchiv, Familienarchiv Attems, Briefe des Grafen Ignaz Attems, K. 19, H. 87; by kind permission).\n\nThe cover page is designed by Žiga Okorn (Uvid.si d.o.o.).')"/>
                </p>
            </div>
        </xsl:if>
        <br/>
        <p class="text-center">
            <!-- založnik -->
            <xsl:for-each select="tei:docImprint/tei:publisher">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
            <!-- kraj izdaje -->
            <xsl:for-each select="tei:docImprint/tei:pubPlace">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
            <!-- leto izdaje -->
            <xsl:for-each select="tei:docImprint/tei:docDate">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
        </p>
        <br/>
        <!-- dodani povzetki -->
        <xsl:for-each select="ancestor::tei:TEI/tei:teiHeader/tei:profileDesc/tei:abstract">
            <xsl:choose>
                <xsl:when test="@xml:lang = 'en'">
                    <p>
                        <xsl:text>ABSTRACT: </xsl:text>
                        <xsl:value-of select="."/>
                    </p>
                    <p>
                        <xsl:text>KEYWORDS: </xsl:text>
                        <xsl:for-each
                            select="../tei:textClass/tei:keywords[@xml:lang = 'en']/tei:term">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                    <br/>
                    <br/>
                </xsl:when>
                <xsl:when test="@xml:lang = 'sl'">
                    <p>
                        <xsl:text>POVZETEK: </xsl:text>
                        <xsl:value-of select="."/>
                    </p>
                    <p>
                        <xsl:text>KLJUČNE BESEDE: </xsl:text>
                        <xsl:for-each
                            select="../tei:textClass/tei:keywords[@xml:lang = 'sl']/tei:term">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                    <br/>
                    <br/>
                </xsl:when>
                <xsl:when test="@xml:lang = 'de'">
                    <p>
                        <xsl:text>ABSTRAKT: </xsl:text>
                        <xsl:value-of select="."/>
                    </p>
                    <p>
                        <xsl:text>SCHLÜSSELBEGRIFFE: </xsl:text>
                        <xsl:for-each
                            select="../tei:textClass/tei:keywords[@xml:lang = 'de']/tei:term">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </p>
                    <br/>
                    <br/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>Unknown abstract language <xsl:value-of select="@xml:lang"
                        /></xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <br/>
        <br/>
        <!-- dodam še podatke za slike na naslovnici -->
        <xsl:copy-of select="$images_on_titlepage"/>
        <br/>
        <!-- Dodani logo -->
        <div class="row">
            <div class="small-4 columns text-center">
                <p>
                    <a href="http://www.oesterreichische-geschichte.at" target="_blank">
                        <img src="logo-Kommission.jpg" alt="Logo Kommision für neuere Geschichte Österreichs" style="height:150px;"/>
                    </a>
                </p>
            </div>
            <div class="small-4 columns text-center">
                <p>
                    <a href="https://www.zrc-sazu.si/" target="_blank">
                        <img src="logoZRC-SAZU.png" alt="Logo ZRC SAZU" style="height:150px;"/>
                    </a>
                </p>
            </div>
            <div class="small-4 columns text-center">
                <p>
                    <a href="http://sd18.zrc-sazu.si/" target="_blank">
                        <img src="logo_SD18.jpg" alt="Logo DSD18"/>
                    </a>
                </p>
            </div>
        </div>
        <br/>
    </xsl:template>


</xsl:stylesheet>
