<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs"
   version="2.0">

   <xsl:import href="../../../../pub-XSLT/Stylesheets/html5-foundation6-chs/to.xsl"/>
    
   <xsl:import href="text-critical.xsl"/>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6 http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed:
            
            1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
            Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
            
            2. http://www.opensource.org/licenses/BSD-2-Clause
            
            
            
            Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are
            met:
            
            * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer.
            
            * Redistributions in binary form must reproduce the above copyright
            notice, this list of conditions and the following disclaimer in the
            documentation and/or other materials provided with the distribution.
            
            This software is provided by the copyright holders and contributors
            "as is" and any express or implied warranties, including, but not
            limited to, the implied warranties of merchantability and fitness for
            a particular purpose are disclaimed. In no event shall the copyright
            holder or contributors be liable for any direct, indirect, incidental,
            special, exemplary, or consequential damages (including, but not
            limited to, procurement of substitute goods or services; loss of use,
            data, or profits; or business interruption) however caused and on any
            theory of liability, whether in contract, strict liability, or tort
            (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage.
         </p>
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
    <xsl:param name="homeURL">https://dariah-si.github.io/Attems/</xsl:param>
    
   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description"></xsl:param>
   <xsl:param name="keywords"></xsl:param>
   <xsl:param name="title"></xsl:param>
    
    
    <!-- Slovene localisation of eZRC/TEI element, attribute and value names / glosses to Slovene -->
    <!-- Needed for teiHeader localisation and write-out of e.g. Janus elements -->
    <xsl:param name="localisation-file">../teiLocalise-sl.xml</xsl:param>
    <xsl:key name="id" match="tei:*" use="@xml:id"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
        <param name="thisLanguage"></param>
    </doc>
    <xsl:template name="nav-body-head">
        <xsl:param name="thisLanguage"/>
        <xsl:text>Letters</xsl:text>
    </xsl:template>
    
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>V css in javascript Hook dodam viewerjs</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of select="concat($path-general,'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"  rel="stylesheet" type="text/css" />
       <!-- dodan viewerjs -->
       <link href="{concat($path-general,'themes/plugin/viewerjs/1.2.0/dist/viewer.css')}" rel="stylesheet" type="text/css" />
       <!-- dodam projektno specifičen css, ki se nahaja v istem direktoriju kot ostali HTML dokumenti -->
      <link href="project.css" rel="stylesheet" type="text/css"/>
   </xsl:template>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook">
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/jquery.js')}"></script>
      <!-- za highcharts -->
      <xsl:if test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
         <xsl:variable name="jsfile" select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
         <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
         <script src="{$chart-jsfile[1]}"></script>
      </xsl:if>
      <!-- za back-to-top in highcharts je drugače potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je že vsebovana zgoraj -->
       <!-- dodan viewerjs -->
       <script src="{concat($path-general,'themes/plugin/viewerjs/1.2.0/dist/viewer.js')}"></script>
       <!-- dodan css jstree (mora biti za jquery.js -->
       <link href="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/themes/default/style.min.css')}" rel="stylesheet" type="text/css" />
       <!-- dodan jstree -->
      <script src="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/jstree.min.js')}"></script>
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
       
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/what-input.js')}"></script>
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/foundation.min.js')}"></script>
      <script src="{concat($path-general,'themes/foundation/6/js/app.js')}"></script>
      <!-- back-to-top -->
      <script src="{concat($path-general,'themes/js/plugin/back-to-top/back-to-top.js')}"></script>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Prelome strani izkoristim za povezave na dinamično stran para.html</desc>
    </doc>
    <xsl:template match="tei:pb">
        <xsl:variable name="facs-id" select="substring-after(@facs,'#')"/>
        
        <xsl:variable name="image" select=" substring-before(ancestor::tei:TEI/tei:facsimile/tei:graphic[@xml:id=$facs-id]/@url,'/info.json')"/>
        <xsl:variable name="image-thumb-iiif" select="concat($image,'/full/,200/0/default.jpg')"/>
        <xsl:variable name="image-small-iiif" select="concat($image,'/full/,600/0/default.jpg')"/>
        <xsl:variable name="image-large-iiif" select="concat($image,'/full/,1200/0/default.jpg')"/>
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
        <desc></desc>
    </doc>
    <xsl:template match="tei:fw">
        <div class="pageNum" style="text-align: center;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc></desc>
    </doc>
    <xsl:template match="tei:label">
        <div class="{if (@rend) then (concat('text',@rend)) else 'padding'}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- poenostavljeno procesiranje besed, ločil in presledkov -->
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc></desc>
    </doc>
    <xsl:template match="tei:w">
        <xsl:apply-templates/>
    </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc></desc>
    </doc>
    <xsl:template match="tei:pc">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc></desc>
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
        <desc>Pri app procesiram samo lemo. Vsebino elementov rdg procesiram pri vzporednem prikazu.</desc>
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
    
</xsl:stylesheet>
