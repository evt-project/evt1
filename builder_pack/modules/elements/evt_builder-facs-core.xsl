<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:eg="http://www.tei-c.org/ns/Examples"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc" xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="#all">
	
	<xd:doc type="stylesheet">
		<xd:short>
			EN: Templates used to process the TEI elements of the CORE module.
			IT: I template per la trasformazione degli elementi TEI del modulo Core.
		</xd:short>
	</xd:doc>
	
	
	<!--             -->
	<!-- Page layout -->
	<!--             -->
	
	<!-- P Paragraphs -->
	<xsl:template match="tei:p" mode="facs">
		<xsl:element name="span">
			<xsl:attribute name="class" select="$ed_name1,name()" separator="-"/>
			<xsl:apply-templates mode="#current"> </xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	
	<!-- L Verse line-->
	<xsl:template match="tei:l" mode="facs">
		<xsl:apply-templates mode="#current"/> 
		<xsl:text> </xsl:text><!--important-->
	</xsl:template>
	
	<!-- CDP:embedded -->
	<!-- LINE Verse line-->
	<xsl:template match="tei:line" mode="facs">
		<xsl:if test="current()[not((string-length(normalize-space()))= 0)]"><!-- Escludo elementi <line> vuoti -->
			<xsl:element name="div">
				<xsl:attribute name="class" select="$ed_name1"/>
				<xsl:if test="@n">
					<xsl:element name="span">
						<xsl:attribute name="class" select="$ed_name1, 'lineN'" separator="-"/>
						<xsl:value-of select="if(string-length(@n) &gt; 1) then(@n) else(concat('&#xA0;&#xA0;',@n))"/><xsl:text>&#xA0;&#xA0;</xsl:text>
					</xsl:element>
				</xsl:if>
				<xsl:element name="div">
					<!-- Aggiungi il valore di @rend alla classe. Se in @rend è presente un '.' viene sostituito con un '_' -->					
					<xsl:attribute name="class" select="if(@rend) then ($ed_name1, translate(@rend, '.', '_')) else ($ed_name1, 'left')" separator="-"/>
					<xsl:apply-templates mode="#current"/>
					<xsl:if test="(following-sibling::*[1][self::tei:line])">
						<xsl:value-of disable-output-escaping="yes">&lt;br/&gt;</xsl:value-of>
					</xsl:if>
					<xsl:text> </xsl:text><!--important-->
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<!-- ZONE -->
	<xsl:template match="tei:zone" mode="facs">
		<xsl:apply-templates mode="#current"/>
		<xsl:if test="not(current()[@lrx][@lry][@ulx][@uly])"><!-- in questo modo se non c'e' collegamento testo immagine le zone vengono separate -->
			<xsl:value-of disable-output-escaping="yes">&lt;br/&gt;</xsl:value-of>
		</xsl:if>
		<xsl:text> </xsl:text><!--important-->
	</xsl:template>
	
	<!-- DESC -->
	<xsl:template match="tei:desc" mode="facs">
		<xsl:text> </xsl:text>
	</xsl:template>
	<!-- CDP:embedded END -->
	
	<!-- Line break -->
	<!-- IT: Ignora i lb che hanno xml:id che termina con 'r' e riporta quelli che hanno xml:id che termina con 'o' eliminando quest'ultimo carattere -->
	<xsl:template match="tei:lb" mode="facs">
		<xsl:choose>
			<xsl:when test="@xml:id">
				<xsl:choose>
					<xsl:when test="not(ends-with(@xml:id, 'reg'))">
						<xsl:element name="tei:lb">
							<xsl:copy-of select="@* except(@xml:id)"></xsl:copy-of>
							<xsl:attribute name="{@xml:id/name()}" select="if(ends-with(@xml:id, 'orig')) then(replace(@xml:id, 'orig', '')) else(@xml:id)"/>
						</xsl:element>
						<xsl:if test="@n">
							<xsl:element name="span">
								<xsl:attribute name="class" select="$ed_name1,'lineN'" separator="-"/>
								<xsl:value-of select="if(string-length(@n) &gt; 1) then(@n) else(concat('&#xA0;&#xA0;',@n))"/><xsl:text>&#xA0;&#xA0;</xsl:text>
							</xsl:element>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><xsl:copy-of select="."/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- CDP:embedded 
	<xsl:template match="tei:zone" mode="facs">
		<xsl:element name="div">
			<xsl:attribute name="id"><xsl:value-of select="@xml:id"></xsl:value-of></xsl:attribute>
			<xsl:attribute name="class">Zone</xsl:attribute>
			<xsl:for-each select="tei:line">
				<xsl:apply-templates select="current()" mode="#current"></xsl:apply-templates>
			</xsl:for-each>
			<xsl:text> </xsl:text>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="tei:line" mode="facs">
		<xsl:if test="current()[not((string-length(normalize-space()))= 0)]">
			<xsl:element name="div">
				<xsl:attribute name="class">Line</xsl:attribute>
				<xsl:if test="@n">
					<xsl:element name="span">
						<xsl:attribute name="class" select="'dipl-lineN'"/>
						<xsl:value-of select="if(string-length(@n) &gt; 1) then(@n) else(concat('&#xA0;&#xA0;',@n))"/><xsl:text>&#xA0;&#xA0;</xsl:text>
					</xsl:element>
				</xsl:if>
				<xsl:apply-templates mode="#current"/> 
				<xsl:text> </xsl:text>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="tei:note" mode="facs">
		<xsl:element name="span">
			<xsl:attribute name="class" select="'nota'" />
			<xsl:copy-of select="."></xsl:copy-of>
		</xsl:element>
	</xsl:template>
	
	 CDP:embedded END -->
	
	<!-- Page break -->
	<xsl:template match="tei:pb" mode="facs">
		<xsl:copy-of select="."/>
	</xsl:template>
	
	
	
	<!--               -->
	<!-- Transcription -->
	<!--               -->
	
	<!-- Choice -->
	<xsl:template match="tei:choice" mode="facs" priority="3">
		<xsl:choose>
			<!-- IT: Questo è per la prima parte di CHOICE (che contine un el ORIG), la parte che dovrà contenere la tooltip -->
			<xsl:when test="@part=1">
				<!--ORIG 1: <xsl:copy-of select="tei:orig"></xsl:copy-of>
				<xsl:variable name="choiceId" select="orig/ancestor::tei:choice[1]/@id"></xsl:variable>
				siblings:	<xsl:copy-of select="orig/ancestor::node()[parent::node()[name()=$start_split]]/following-sibling::node()[not(self::lb)][position() lt 3]"/>
				REG 1: <xsl:copy-of select="orig/ancestor::node()[parent::node()[name()=$start_split]]/tei:reg/node()"/>
				REG: <xsl:copy-of select="orig/ancestor::node()[parent::node()[name()=$start_split]]/following-sibling::node()[not(self::lb)][position() lt 3]//tei:reg/node()"/>
				--> 
				<xsl:element name="span">
					<xsl:attribute name="class" select="$ed_name1,'choice_popup'" separator="-"/>
					<xsl:if test="@id">
						<xsl:variable name="vApos">'</xsl:variable>
						<xsl:attribute name="class" select="$ed_name1,'-choice_popup ',@id" separator=""/>
						<xsl:attribute name="onmouseover" select="'overChoice(',$vApos,@id,$vApos,')'" separator=""/>
						<xsl:attribute name="onmouseout" select="'outChoice(',$vApos,@id,$vApos,')'" separator=""/>
					</xsl:if>
					<xsl:element name="span">
						<xsl:attribute name="class" select="$ed_name1,'reg'" separator="-"/>
						<xsl:variable name="choiceId" select="orig/ancestor::tei:choice[1]/@id"></xsl:variable>
						<xsl:apply-templates select="orig/ancestor::node()[parent::node()[name()=$start_split]]//tei:choice[@id=$choiceId]//tei:reg/node(),
							orig/ancestor::node()[parent::node()[name()=$start_split]]/following-sibling::node()[not(self::lb)][position() lt 3]//tei:choice[@id=$choiceId]//tei:reg/node()"
							mode="#current"/>
					</xsl:element>
					<xsl:sequence select="' '"/>
					<xsl:apply-templates select="tei:orig" mode="#current"> </xsl:apply-templates>
				</xsl:element>
			</xsl:when>
			<!-- IT: Questo è per le altre parti, che dovranno contenere solo ORIG-->
			<xsl:when test="@part and not(@part=1)">
				<xsl:element name="span">
					<xsl:attribute name="class" select="$ed_name1,'choice_popup'" separator="-"/>
					<xsl:if test="@id">
						<xsl:variable name="vApos">'</xsl:variable>
						<xsl:attribute name="class" select="$ed_name1,'-choice_popup ',@id" separator=""/>
						<xsl:attribute name="onmouseover" select="'overChoice(',$vApos,@id,$vApos,')'" separator=""/>
						<xsl:attribute name="onmouseout" select="'outChoice(',$vApos,@id,$vApos,')'" separator=""/>
					</xsl:if>
					<xsl:apply-templates select="orig" mode="#current"/>
				</xsl:element>
			</xsl:when>
			<!-- IT: Questo è per i casi in cui CHOICE non è suddiviso in più parti-->
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="tei:sic">
						<xsl:apply-templates select="tei:sic" mode="#current"> </xsl:apply-templates>
					</xsl:when>
					<xsl:when test="tei:abbr">
						<xsl:apply-templates select="tei:abbr" mode="#current"> </xsl:apply-templates>
					</xsl:when>	
					<xsl:when test="tei:orig">
						<xsl:choose>
							<!-- IT: 1. escludi i choice che contengono reg vuoti (che contengono solo white-spaces) usati per la punteggiatura
									 2. escludi i choice che contengono reg che contengono solo punteggiatura-->
							<xsl:when test="tei:reg[not(descendant::tei:pc)][normalize-space()] or
											(tei:reg[descendant::tei:pc] and tei:reg/node()[not(self::tei:pc)]/normalize-space())">
								<xsl:element name="span">
									<xsl:attribute name="class" select="$ed_name1,'choice_popup'" separator="-"/>
									<xsl:apply-templates select="tei:reg" mode="#current"> </xsl:apply-templates>
									<xsl:sequence select="' '"/>
									<xsl:apply-templates select="tei:orig" mode="#current"> </xsl:apply-templates>
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="tei:orig" mode="#current"> </xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!--SUBST substitution -->
	<xsl:template match="tei:subst" mode="facs" priority="3">
		<xsl:element name="span">
			<xsl:attribute name="class" select="$ed_name1,name()" separator="-"/>
			<xsl:apply-templates select="tei:del" mode="#current"> </xsl:apply-templates>
			<xsl:apply-templates select="tei:add" mode="#current"> </xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	
	<!-- ADD Addition -->
	<xsl:template match="tei:add" mode="facs" priority="2">
		<xsl:choose>
			<xsl:when test="ancestor::reg">
				<xsl:choose>
					<xsl:when test="@place='sup'">\<xsl:element name="span">
						<xsl:attribute name="class" select="$ed_name1,concat(name(),' ',$ed_name1),@place" separator="-"/>
						<xsl:apply-templates mode="#current"/> 
					</xsl:element>/</xsl:when>
					<xsl:when test="@place='sub'">/<xsl:element name="span">
						<xsl:attribute name="class" select="$ed_name1,concat(name(),' ',$ed_name1),@place" separator="-"/>
						<xsl:apply-templates mode="#current"/>
					</xsl:element>\</xsl:when>
					<xsl:otherwise><xsl:element name="span">
						<xsl:attribute name="class" select="$ed_name1,name()" separator="-"/>
						<xsl:apply-templates mode="#current"/> 
					</xsl:element></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="span">
					<!-- if @place then "ed_name-add ed_name-@place" else "ed_name-add" -->
					<xsl:attribute name="class" select="if(@place) then($ed_name1,concat(name(),' ',$ed_name1),@place) else($ed_name1,name())" separator="-"/>
					<xsl:apply-templates mode="#current"/> 
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!--
		SIC Text reproduced although apparently incorrect or inaccurate
		DEL Deletions
		DAMAGE Damage
		ORIG Original form
		REG Regularization
		ABBR Abbreviation
	-->
	<xsl:template match="tei:sic|tei:del|tei:damage|tei:am|tei:orig|tei:reg|tei:abbr" mode="facs"
		priority="2">
		<xsl:element name="span">
			<xsl:attribute name="class" select="$ed_name1,name()" separator="-"/>
			<xsl:apply-templates mode="#current"/> 
		</xsl:element>
	</xsl:template>
	
	
	<!--
		CORR Correction
		EXPAN Expansion
	-->
	<xsl:template match="tei:corr" mode="facs" priority="2">
		<!-- Do nothing -->
	</xsl:template>	
	<xsl:template match="tei:expan[ancestor::tei:reg]" mode="facs" priority="2">
		<xsl:element name="span">
			<xsl:attribute name="class" select="$ed_name1,name()" separator="-"/>
			<xsl:apply-templates mode="#current"/> 
		</xsl:element>
	</xsl:template>
	
	<!-- HI Highlighted text -->
	<xsl:template match="tei:hi" mode="facs" priority="2">
		<xsl:element name="span">
			<!-- Aggiungi il valore di @rend alla classe. Se in @rend è presente un '.' viene sostituito con un '_' -->
			<xsl:attribute name="class" select="$ed_name1,name(),translate(@rend, '.', '_')" separator="-"/>
			<xsl:apply-templates mode="#current"/> 
		</xsl:element>
	</xsl:template>
	
</xsl:stylesheet>