<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc" 
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all">
        
        <xd:doc type="stylesheet">
            <xd:short>
                IT: Template per la generazione del file structure.xml
            </xd:short>
        </xd:doc>
        
    <!-- All -->
    <xd:doc>
        <xd:short>
            IT: 
        </xd:short>
        <xd:detail>
            IT: 
        </xd:detail>
    </xd:doc>
    <!--<xsl:template match="*" mode="structure_generation">
        <xsl:result-document method="xml" href="{$filePrefix}/data/output_data/structure.xml" indent="yes">
            <xml>
                <editions>
                    <xsl:for-each select="$edition_array">
                        <edition><xsl:value-of select="."/></edition>
                    </xsl:for-each>
                </editions>
                <textpage>
                    <xsl:for-each select="$root//tei:div[@subtype='edition_text']">
                        <text>
                            <xsl:attribute name="n" select="@n"></xsl:attribute>
                            <xsl:for-each select=".//tei:pb">
                                <pb><xsl:value-of select="@n"></xsl:value-of></pb>
                            </xsl:for-each>
                        </text>
                    </xsl:for-each>
                </textpage>
                <pages>
                    <xsl:for-each-group select="//tei:pb" group-starting-with="node()[ends-with(@n, 'v') or (ends-with(@n, 'r') and not(preceding-sibling::node()[ends-with(@n, 'v')]) ) or (not (ends-with(@n, 'v') or ends-with(@n, 'r')))]" >
                        <pair>
                            <xsl:for-each select="current-group()/self::tei:pb">
                                <pb><xsl:value-of select="@n"></xsl:value-of></pb>
                            </xsl:for-each>
                        </pair>
                    </xsl:for-each-group>
                </pages>
            </xml>
        </xsl:result-document>
    </xsl:template>-->
    
    <!-- CDP:embedded -->
    <!--<xsl:template match="*" mode="structure_generation4embedded">
        <xsl:result-document method="xml" href="{$filePrefix}/data/output_data/structure.xml" indent="yes">
            <xml>
                <editions>
                    <xsl:for-each select="$edition_array">
                        <edition><xsl:value-of select="."/></edition>
                    </xsl:for-each>
                </editions>
                <textpage>
                    <xsl:for-each select="$root//tei:sourceDoc">
                        <text>
                            <xsl:attribute name="n" select="@xml:id"></xsl:attribute>
                            <xsl:for-each select="current()/child::node()">
                                <xsl:if test="self::tei:surface">
                                    <pb><xsl:value-of select="@n"></xsl:value-of></pb>    
                                </xsl:if>
                                <xsl:if test="self::tei:surfaceGrp">
                                    <xsl:for-each select="current()/child::node()">-->
                                    <!-- gestisco due livelli di annidamento di <surfaceGrp> -->
                                        <!--<xsl:if test="self::tei:surface">
                                            <xsl:for-each select="current()">
                                                <pb><xsl:value-of select="@n"></xsl:value-of></pb>
                                            </xsl:for-each>
                                        </xsl:if>
                                        <xsl:if test="self::tei:surfaceGrp">-->
                                        <!-- primo livello di annidamento <surfaceGrp> -->
                                            <!--<xsl:for-each select="current()/child::tei:surface">
                                                <pb><xsl:value-of select="@n"></xsl:value-of></pb>
                                            </xsl:for-each>
                                        </xsl:if>
                                        
                                    </xsl:for-each>
                                </xsl:if>
                            </xsl:for-each>
                        </text>
                    </xsl:for-each>
                </textpage>
                <pages>
                    <xsl:for-each select="$root//tei:sourceDoc">
                        <xsl:for-each select="child::node()">
                            <xsl:if test="self::tei:surface">
                                <xsl:call-template name="surfaceStructure" />
                            </xsl:if>
                            <xsl:if test="self::tei:surfaceGrp">
                                <xsl:for-each select="current()/child::node()">
                                    <xsl:if test="self::tei:surface">
                                        <xsl:call-template name="surfaceStructure" />
                                    </xsl:if>
                                    <xsl:if test="self::tei:surfaceGrp">
                                        <xsl:for-each select="current()/tei:surface">
                                            <xsl:call-template name="surfaceStructure" />
                                        </xsl:for-each>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                </pages>
            </xml>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="surfaceStructure">-->
        <!-- per gestire i casi in cui la prima pagina è il recto, ovvero quella di destra -->
        <!--<xsl:if test="(ends-with(@n, 'r')) and not(current()/preceding-sibling::tei:surface[1][ends-with(@n, 'v')])">
            <pair>
                <pb><xsl:value-of select="@n" /></pb>
            </pair>
        </xsl:if>
        <xsl:if test="ends-with(@n, 'v')">
            <pair>
                <pb><xsl:value-of select="@n"></xsl:value-of></pb>
                <xsl:if test="current()/following-sibling::tei:surface[1][ends-with(@n, 'r')]">
                    <pb><xsl:value-of select="current()/following-sibling::tei:surface[1]/@n"></xsl:value-of></pb>
                </xsl:if>
            </pair>
        </xsl:if> 
    </xsl:template>  -->
    <xsl:template name="getLastPb">
        <xsl:choose>
            <xsl:when test="current()/tei:body/descendant::tei:pb">
                <xsl:attribute name="n" select="if(current()/descendant::tei:pb[last()]/@n) then(current()/descendant::tei:pb[last()]/@n) else(current()/descendant::tei:pb[last()]/@xml:id)"></xsl:attribute>
                <xsl:value-of select="current()/descendant::tei:pb[last()]/@xml:id"></xsl:value-of>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="current()/preceding-sibling::tei:text[1]">
                    <xsl:call-template name="getLastPb"></xsl:call-template>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*" mode="structure_generation">
        <xsl:result-document method="xml" href="{$filePrefix}/data/output_data/structure.xml" indent="yes">
            <xml>
                <xsl:if test="$regesto=true()">
                    <regesto active="1" />
                </xsl:if>
                <editions>
                    <xsl:for-each select="$edition_array">
                        <edition><xsl:value-of select="."/></edition>
                    </xsl:for-each>
                </editions>
                <textpage>
                    <xsl:if test="$root//tei:sourceDoc">
                        <xsl:for-each select="$root//tei:sourceDoc">
                            <text>
                                <xsl:attribute name="n" select="@xml:id"></xsl:attribute>
                                <xsl:for-each select="current()/child::node()">
                                    <xsl:if test="self::tei:surface">
                                        <pb>
                                            <xsl:attribute name="n" select="if(@n) then(@n) else(@xml:id)"></xsl:attribute>
                                            <xsl:value-of select="@xml:id"></xsl:value-of>
                                        </pb>   
                                    </xsl:if>
                                    <xsl:if test="self::tei:surfaceGrp">
                                        <xsl:for-each select="current()/child::node()"><!-- gestisco due livelli di annidamento di <surfaceGrp> -->
                                            <xsl:if test="self::tei:surface">
                                                <xsl:for-each select="current()">
                                                    <pb>
                                                        <xsl:attribute name="n" select="if(@n) then(@n) else(@xml:id)"></xsl:attribute>
                                                        <xsl:value-of select="@xml:id"></xsl:value-of>
                                                    </pb>
                                                </xsl:for-each>
                                            </xsl:if>
                                            <xsl:if test="self::tei:surfaceGrp"><!-- primo livello di annidamento <surfaceGrp> -->
                                                <xsl:for-each select="current()/child::tei:surface">
                                                    <pb>
                                                        <xsl:attribute name="n" select="if(@n) then(@n) else(@xml:id)"></xsl:attribute>
                                                        <xsl:value-of select="@xml:id"></xsl:value-of>
                                                    </pb>
                                                </xsl:for-each>
                                            </xsl:if>
                                            
                                        </xsl:for-each>
                                    </xsl:if>
                                </xsl:for-each>
                            </text>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="$root//tei:text">
                        <xsl:choose>
                            <xsl:when test="$root//tei:text/tei:group">
                                <!-- Gestione TEXT multipli in tei:group -->
                                <xsl:for-each select="$root//tei:text/tei:group/tei:text">
                                    <text>
                                        <xsl:attribute name="n" select="@xml:id"></xsl:attribute>
                                        <xsl:if test="not(current()/tei:body/tei:div/child::*[1][self::tei:pb]) and not(current()/tei:body/tei:div/child::*[1][self::tei:p]/child::*[1][self::tei:pb])">
                                            <pb>
                                                <xsl:choose>
                                                    <xsl:when test="current()/preceding-sibling::tei:text[1]/descendant::tei:pb">
                                                        <xsl:attribute name="n" select="if(current()/preceding-sibling::tei:text[1]/descendant::tei:pb[last()]/@n) then (current()/preceding-sibling::tei:text[1]/descendant::tei:pb[last()]/@n) else (current()/preceding-sibling::tei:text[1]/descendant::tei:pb[last()]/@xml:id)"></xsl:attribute>
                                                        <xsl:value-of select="current()/preceding-sibling::tei:text[1]/descendant::tei:pb[last()]/@xml:id"></xsl:value-of>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:for-each select="current()/preceding-sibling::tei:text[1]">
                                                            <xsl:call-template name="getLastPb"></xsl:call-template>
                                                        </xsl:for-each>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </pb>
                                        </xsl:if>
                                        <xsl:for-each select=".//tei:pb">
                                            <pb>
                                                <xsl:attribute name="n" select="if(@n) then(@n) else(@xml:id)"></xsl:attribute>
                                                <xsl:value-of select="@xml:id"></xsl:value-of>
                                            </pb>
                                        </xsl:for-each>
                                    </text>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each select="$root//tei:div[@subtype='edition_text']">
                                    <text>
                                        <xsl:attribute name="n" select="@n"></xsl:attribute>
                                        <xsl:for-each select=".//tei:pb">
                                            <pb>
                                                <xsl:attribute name="n" select="if(@n) then (@n) else (@xml:id)"></xsl:attribute>
                                                <xsl:value-of select="@xml:id"></xsl:value-of>
                                            </pb>
                                        </xsl:for-each>
                                    </text>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </textpage>
                <pages>
                    <xsl:if test="$root//tei:sourceDoc">
                        <xsl:for-each select="$root//tei:sourceDoc">
                            <xsl:for-each select="child::node()">
                                <xsl:if test="self::tei:surface">
                                    <xsl:call-template name="surfaceStructure" />                                    
                                </xsl:if>
                                <xsl:if test="self::tei:surfaceGrp">
                                    <xsl:for-each select="current()/child::node()"><!-- gestisco due livelli di annidamento di <surfaceGrp> -->
                                        <xsl:if test="self::tei:surface">
                                            <xsl:call-template name="surfaceStructure" />
                                        </xsl:if>
                                        <xsl:if test="self::tei:surfaceGrp">
                                            <xsl:for-each select="current()/tei:surface">
                                                <xsl:call-template name="surfaceStructure" />
                                            </xsl:for-each>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>
                        
                    </xsl:if>
                    <xsl:if test="$root//tei:text">
                        <!-- IT: Crea un nuovo gruppo ogni volta che trova un pb con attributo @n che: - finisce con v (104v seguito da 105v vengno inseriti in due gruppi diversi)
                                                                                                       - finisce con r, ma è preceduto da un pb che non finisce con v (104r e 105r vengno inseriti in due gruppi diversi)
                                                                                                       - finisce con r, è preceduto da un pb che finisce con v, ma il numero del @n che finisce con r non è consecutivo a quello del @n che finisce con v (104v e 106r vengno inseriti in due gruppi diversi)
                                                                                                       - non finisce né con v né con r (104 e 105 vengno inseriti in due gruppi diversi)
                        -->
                        <xsl:for-each-group select="$step0//tei:pb" group-starting-with="node()[ends-with(@n, 'v') 
                                                                                                or (ends-with(@n, 'r') and not(preceding-sibling::tei:pb[1][ends-with(@n, 'v')]) )
                                                                                                or (ends-with(@n, 'r') and preceding-sibling::tei:pb[1][ends-with(@n, 'v')] and not( number(translate(@n,'r',''))= number(translate(preceding-sibling::tei:pb[1]/@n,'v',''))+1))
                                                                                                or (not (ends-with(@n, 'v') or ends-with(@n, 'r')))]" >
                            <pair>
                                <xsl:for-each select="current-group()/self::tei:pb">
                                    <pb>
                                        <xsl:attribute name="n" select="@n"></xsl:attribute>
                                        <xsl:value-of select="@xml:id"></xsl:value-of>
                                    </pb>
                                </xsl:for-each>
                            </pair>
                        </xsl:for-each-group>
                    </xsl:if>
                </pages>
            </xml>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="surfaceStructure">
        <xsl:choose>
            <xsl:when test="(ends-with(@n, 'r')) or (ends-with(@n, 'v'))">
                <xsl:if test="(ends-with(@n, 'r')) and not(current()/preceding-sibling::tei:surface[1][ends-with(@n, 'v')])">
                    <pair>
                        <pb>
                            <xsl:attribute name="n" select="@n"></xsl:attribute>
                            <xsl:value-of select="@xml:id"></xsl:value-of>
                        </pb>
                    </pair>
                </xsl:if>
                <xsl:if test="ends-with(@n, 'v')">
                    <pair>
                        <pb>
                            <xsl:attribute name="n" select="@n"></xsl:attribute>
                            <xsl:value-of select="@xml:id"></xsl:value-of>
                        </pb>
                        <xsl:if test="current()/following-sibling::tei:surface[1][ends-with(@n, 'r')]">
                            <!-- <pb><xsl:value-of select="current()/following-sibling::tei:surface[1]/@n"></xsl:value-of></pb> -->
                            <pb>
                                <xsl:attribute name="n" select="current()/following-sibling::tei:surface[1]/@n"></xsl:attribute>
                                <xsl:value-of select="current()/following-sibling::tei:surface[1]/@xml:id"></xsl:value-of>
                            </pb>
                        </xsl:if>
                    </pair>
                </xsl:if> 
            </xsl:when>
            <xsl:otherwise>
                <pair>
                    <pb>
                        <xsl:attribute name="n" select="@n"></xsl:attribute>
                        <xsl:value-of select="@xml:id"></xsl:value-of>
                    </pb>
                </pair>
            </xsl:otherwise>
        </xsl:choose><!-- per gestire i casi in cui la prima pagina è il recto, ovvero quella di destra -->
    </xsl:template>
</xsl:stylesheet>