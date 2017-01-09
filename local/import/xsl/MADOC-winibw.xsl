<?xml version="1.0" encoding="UTF-8"?>
<!-- vim: set sw=2:ts=2: -->
<xsl:stylesheet version="1.0"
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
  <xsl:param name="collection">MADOC</xsl:param>

  <xsl:template match="/">
    <add>
      <doc>

        <field name="collection">
            <xsl:value-of select="$collection"/>
        </field>

        <xsl:choose>
          <xsl:when test="//dc:identifier[@xsi:type='urn:nbn']">
            <field name="id">
              <xsl:value-of select="//dc:identifier[@xsi:type='urn:nbn']" />
            </field>
            <field name="id_urn_txt">
              <xsl:value-of select="//dc:identifier[@xsi:type='urn:nbn']/text()"/>
            </field>
            <field name="url">
              <xsl:value-of select="concat('http://nbn-resolving.org/', //dc:identifier[@xsi:type='urn:nbn']/text())"/>
            </field>
          </xsl:when>
          <xsl:otherwise>
            <!-- Combination of ID and Title without alphanumerics -->
            <field name="id">
              <xsl:value-of select="
                concat(
                  concat('madoc-',
                    substring-after(
                      //ddb:identifier[@ddb:type='URL'][1],
                      'http://ub-madoc.bib.uni-mannheim.de/')),
                  translate(
                    //dc:title[1]/text(),
                    translate(
                      //dc:title[1]/text(),
                      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
                      ''),
                    '_'))
                " />
              <!-- <xsl:value-of select="concat('madoc-non-urn-', substring-after(//ddb:identifier[@ddb:type='URL'][1], 'http://ub-madoc.bib.uni-mannheim.de/'))"/> -->
            </field>
          </xsl:otherwise>
        </xsl:choose>


        <!-- <xsl:for-each select="//dc:coverage"> -->
          <!--   <field name="TODO"> -->
            <!--     <xsl:value-of select="."/> -->
            <!--   </field> -->
          <!-- </xsl:for-each> -->
        <xsl:for-each select="//dc:creator[1]">
          <field name="author">
            <xsl:value-of select="pc:person/pc:name/pc:surName"/>
            <xsl:text>,&#160;</xsl:text>
            <xsl:value-of select="pc:person/pc:name/pc:foreName"/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dc:creator[position()>1]">
          <field name="author2">
            <xsl:value-of select="pc:person/pc:name/pc:surName"/>
            <xsl:text>,&#160;</xsl:text>
            <xsl:value-of select="pc:person/pc:name/pc:foreName"/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dc:contributor">
          <field name="author_additional">
            <xsl:value-of select="pc:person/pc:name/pc:surName"/>
            <xsl:text>,&#160;</xsl:text>
            <xsl:value-of select="pc:person/pc:name/pc:foreName"/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dcterms:abstract">
          <field name="contents">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dcterms:abstract[1]">
          <field name="description">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <field name="publishDate">
          <xsl:value-of select="//dcterms:issued"/>
        </field>

        <xsl:for-each select="//dcterms:dateAccepted">
          <xsl:if test="normalize-space(string(.)) != ''">
            <field name="publishDate">
              <xsl:value-of select="."/>
            </field>
          </xsl:if>
        </xsl:for-each>

        <xsl:for-each select="//dc:description">
          <field name="description">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dc:subject[@xsi:type='xMetaDiss:DDC-SG']">
          <field name="dewey-raw">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dc:subject[@xsi:type='xMetaDiss:SWD']">
          <xsl:call-template name="tokenize">
            <xsl:with-param name="separator" select="','"/>
            <xsl:with-param name="fieldname" select="'topic_facet'"/>
            <xsl:with-param name="text" select="text()"/>
          </xsl:call-template>
          <xsl:call-template name="tokenize">
            <xsl:with-param name="separator" select="','"/>
            <xsl:with-param name="fieldname" select="'topic'"/>
            <xsl:with-param name="text" select="text()"/>
          </xsl:call-template>
        </xsl:for-each>

        <xsl:for-each select="//dcterms:medium[@xsi:type='dcterms:IMT']">
          <field name="internet_media_type_txtF">
            <xsl:choose>
              <xsl:when test="text() = 'application/pdf'">
                <xsl:text>PDF</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </field>
        </xsl:for-each>


        <xsl:for-each select="//dc:language">
          <field name="language">
            <xsl:choose>
              <xsl:when test="text() = 'ger'">
                <xsl:text>English</xsl:text>
              </xsl:when>
              <xsl:when test="text() = 'eng'">
                <xsl:text>German</xsl:text>
              </xsl:when>
              <xsl:when test="text() = 'mul'">
                <xsl:text>Multiple</xsl:text>
              </xsl:when>
              <xsl:when test="text() = 'fre'">
                <xsl:text>French</xsl:text>
              </xsl:when>
              <xsl:when test="text() = 'mis'">
                <xsl:text>Unknown</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </field>
        </xsl:for-each>


        <!-- <xsl:for-each select="//dc:format"> -->
          <!--   <datafield tag="856" ind1=" " ind2=" "> -->
            <!--     <subfield code="q"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <xsl:for-each select="//ddb:identifier[@ddb:type='URL']">
          <field name="url">
            <xsl:value-of select="."/>
          </field>
          <field name="thumbnail">
            <xsl:value-of select="."/>
            <xsl:text>/2/preview.jpg</xsl:text>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dc:title[1]">
          <field name="title">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dc:title[position()>1]">
          <field name="title_sub">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dc:type">
          <field name="format">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//cc:department">
          <field name="institution">
            <xsl:value-of select="cc:name"/>
          </field>
        </xsl:for-each>


        <!-- FULL TEXT -->
        <xsl:for-each select="//ddb:transfer">
        <field name="url">
            <xsl:value-of select="."/>
        </field>
        <!-- <field name="fulltext"> -->
        <!--     <xsl:value-of select="php:function('VuFind::harvestWithTika', string(.))"/> -->
        <!-- </field> -->
      </xsl:for-each>

      </doc>
    </add>
  </xsl:template>


  <!-- HELPERs -->
    <xsl:template match="text/text()" name="tokenize">
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
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                    <xsl:with-param name="fieldname" select="$fieldname"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
