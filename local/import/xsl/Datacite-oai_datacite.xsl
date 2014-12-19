<?xml version="1.0" encoding="UTF-8"?>
<!-- vim: set sw=2:ts=2: -->
<xsl:stylesheet version="1.0"
  xmlns:dcite_oai="http://schema.datacite.org/oai/oai-1.0/"
  xmlns:dcite2="http://datacite.org/schema/kernel-2"
  xmlns:dcite21="http://datacite.org/schema/kernel-2.1"
  xmlns:dcite22="http://datacite.org/schema/kernel-2.2"
  xmlns:dcite3="http://datacite.org/schema/kernel-3"
  xmlns:dcite31="http://datacite.org/schema/kernel-3.1"
  xmlns:dcite32="http://datacite.org/schema/kernel-3.2"

  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:php="http://php.net/xsl"
  xmlns:ddb="http://www.d-nb.de/standards/ddb/"
  xmlns:pc="http://www.d-nb.de/standards/pc/"
  xmlns:cc="http://www.d-nb.de/standards/cc/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xlink="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:doaj="http://www.doaj.org/schemas/">
  <xsl:output indent="yes" encoding="utf-8"/>
  <xsl:param name="institution">Mannheim University</xsl:param>
  <xsl:param name="collection">Datacite-GESIS</xsl:param>

  <!--
       Override built-in XSLT templates
    -->
  <xsl:template match="text()|@*">
    <!-- <xsl:value-of select="."/> -->
    <xsl:message terminate="no">
      <!-- WARNING: Unmatched attribute or text: <xsl:value-of select="name()"/> -->
    </xsl:message>
  </xsl:template>
  <xsl:template match="*">
    <!-- <xsl:message terminate="no">WARNING: Unmatched element: <xsl:value-of select="name()"/> (<xsl:value-of select="namespace-uri()"/>)</xsl:message> -->
    <xsl:apply-templates/>
  </xsl:template>

  <!-- 
       ROOT OF STYLESHEET 
   -->
  <xsl:template match="/dcite_oai:oai_datacite">
    <add>
      <doc>

        <!-- Providing Datacenter -->
        <field name="institution">
          <xsl:value-of select="dcite_oai:datacentreSymbol"/>
        </field>
        <field name="collection">
          <xsl:value-of select="$collection"/>
        </field>

        <xsl:apply-templates/>

      </doc>
    </add>
  </xsl:template>

  <!--          #
                #
       FIELDS   #
                #
                # -->

  <!-- DOI -->
  <xsl:template match="*[local-name()='identifier'][@identifierType='DOI']">
    <field name="id">
      <xsl:value-of select="translate(text(), '/', '-')"/>
    </field>
    <field name="id_doi_txt">
      <xsl:value-of select="text()"/>
    </field>
    <field name="url">
      <xsl:value-of select="concat('http://dx.doi.org/', text())"/>
    </field>
  </xsl:template>

  <!-- Title -->
  <xsl:template match="*[local-name()='title'][not(@titleType)]">
    <field name="title">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- Subtitle -->
  <xsl:template match="*[local-name()='title'][@titleType='Subtitle']">
    <field name="title_sub">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- Alternative Title -->
  <xsl:template match="*[local-name()='title'][@titleType='AlternativeTitle' or @titleType='TranslatedTitle']">
    <field name="title_alt">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- XXX: author2 template must come before author template because of XSLT priority rules -->
  <!-- All authors, corporate and personal alike -->
  <xsl:template match="*[local-name()='creator']">
    <field name="author2">
      <xsl:value-of select="*[local-name()='creatorName']"/>
    </field>
  </xsl:template>

  <!-- First (Personal) Author -->
  <xsl:template match="*[local-name()='creator'][contains(*[local-name()='creatorName']/text(), ', ')][1]">
    <field name="author">
      <xsl:value-of select="*[local-name()='creatorName']"/>
    </field>
  </xsl:template>

  <!-- Contributor -->
  <xsl:template match="*[local-name()='contributor']">
    <field name="author2">
      <xsl:value-of select="*[local-name()='contributorName']"/>
    </field>
  </xsl:template>

  <!-- Publication Date -->
  <xsl:template match="*[local-name()='publicationYear']">
    <field name="publishDate">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- Subjects -->
  <!-- TODO this must take the subjectScheme into account though it is pretty free-form -->
  <xsl:template match="*[local-name()='subject']">
    <field name="topic">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- Version -->
  <xsl:template match="*[local-name()='version']">
    <field name="version_txtF_mv">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- Description -->
  <xsl:template match="*[local-name()='description']">
    <field name="contents">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="*[local-name()='description'][1]">
    <field name="description">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- geoLocationPlace -->
  <xsl:template match="*[local-name()='geoLocationPlace']">
    <field name="geographic">
      <xsl:value-of select="."/>
    </field>
    <field name="geographic_facet">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- dates -->
  <xsl:template match="*[local-name()='dates']/*[local-name()='date'][contains(text(), '/')]">
    <xsl:call-template name="poor-mans-from-to">
      <xsl:with-param name="fieldname">
          <!-- <xsl:message terminate="no"> -->
          <!--   <xsl:value-of select="@dateType"/> -->
          <!-- </xsl:message> -->
        <xsl:choose>
          <!-- TODO -->
          <xsl:when test="@dateType = 'Collected'">
            <xsl:text>created_date_txtF_mv</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>publishDate</xsl:text>
          </xsl:otherwise>

        </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="from">
        <xsl:choose>
          <xsl:when test="contains(text(), '-')">
            <xsl:value-of select="substring-before(substring-before(text(), '/'), '-')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring-before(text(), '/')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param> 
      <xsl:with-param name="to">
        <xsl:choose>
          <xsl:when test="contains(text(), '-')">
            <xsl:value-of select="substring-before(substring-after(text(), '/'), '-')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring-after(text(), '/')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param> 
    </xsl:call-template>
  </xsl:template>


  <!-- ========================================================
       = HELPERs                                              =
       ======================================================== -->

   <!-- Tokenize a string field using 'separator' and output <field> with attribute 'fieldname' for each.  -->
    <xsl:template name="poor-mans-split">
        <xsl:param name="text" select="."/>
        <xsl:param name="separator" select="','"/>
        <xsl:param name="fieldname"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <field>
                  <xsl:attribute name="name">
                    <xsl:value-of select="$fieldname"/>
                  </xsl:attribute>
                  <xsl:value-of select="normalize-space($text)"/>
                </field>
            </xsl:when>
            <xsl:otherwise>
                <field>
                  <xsl:attribute name="name">
                    <xsl:value-of select="$fieldname"/>
                  </xsl:attribute>
                  <xsl:value-of select="normalize-space(substring-before($text, $separator))"/>
                </field>
                <xsl:call-template name="poor-mans-split">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                    <xsl:with-param name="fieldname" select="$fieldname"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Create numeric single-step range (for yearly date ranges) -->
    <xsl:template name="poor-mans-from-to">
      <xsl:param name="fieldname" select="publishDate"/>
      <xsl:param name="from"/>
      <xsl:param name="to"/>
      <xsl:param name="suffix" select="''"/>
      <field>
        <xsl:attribute name="name">
          <xsl:value-of select="$fieldname"/>
        </xsl:attribute>
        <xsl:value-of select="concat($from, $suffix)"/>
      </field>
      <xsl:if test="$to - $from > 1">
        <xsl:call-template name="poor-mans-from-to">
          <xsl:with-param name="fieldname" select="$fieldname"/>
          <xsl:with-param name="from" select="$from + 1"/>
          <xsl:with-param name="to" select="$to"/>
          <xsl:with-param name="suffix" select="$suffix"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:template>

</xsl:stylesheet>
