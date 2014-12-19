<?xml version="1.0" encoding="UTF-8"?>
<!-- vim: set sw=2:ts=2: -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:php="http://php.net/xsl"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xlink="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:doaj="http://www.doaj.org/schemas/">
  <xsl:output method="xml" indent="yes" encoding="utf-8"/>
  <xsl:param name="institution">Mannheim University</xsl:param>
  <xsl:param name="collection">MADOC</xsl:param>

  <xsl:template match="/">
    <add>
      <doc>

        <!-- Injected Identifier (Must be set in oai.ini) -->
        <xsl:for-each select="injectId">
          <field name="id">
            <xsl:value-of select="."/>
          </field>
          <!-- <field name="thumbnail"> -->
          <!--   http://ub-madoc.bib.uni-mannheim.de/<xsl:value-of select="."/>/2/preview.jpg -->
          <!-- </field> -->
        </xsl:for-each>


        <xsl:for-each select="//dc:contributor">
          <field name="author_additional">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <!-- <xsl:for-each select="//dc:coverage"> -->
          <!--   <field name="TODO"> -->
            <!--     <xsl:value-of select="."/> -->
            <!--   </field> -->
          <!-- </xsl:for-each> -->

        <xsl:for-each select="//dc:creator[1]">
          <field name="author">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dc:creator[position()>1]">
          <field name="author2">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select="//dc:date">
          <field name="publishDate">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>	

        <xsl:for-each select="//dc:description">
          <field name="description">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <!-- <xsl:for-each select="//dc:format"> -->
          <!--   <datafield tag="856" ind1=" " ind2=" "> -->
            <!--     <subfield code="q"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <xsl:for-each select="//dc:identifier">
          <field name="url">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <!-- <xsl:for-each select="//dc:language"> -->
          <!--   <datafield tag="546" ind1=" " ind2=" "> -->
            <!--     <subfield code="a"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <xsl:for-each select="//dc:publisher">
          <field name="publisher">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <!-- <xsl:for-each select="//dc:relation"> -->
          <!--   <datafield tag="787" ind1="0" ind2=" "> -->
            <!--     <subfield code="n"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <!-- <xsl:for-each select="//dc:rights"> -->
          <!--   <datafield tag="540" ind1=" " ind2=" "> -->
            <!--     <subfield code="a"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <!-- <xsl:for-each select="//dc:source"> -->
          <!--   <datafield tag="786" ind1="0" ind2=" "> -->
            <!--     <subfield code="n"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <!-- <xsl:for-each select="//dc:subject"> -->
          <!--   <datafield tag="653" ind1=" " ind2=" "> -->
            <!--     <subfield code="a"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

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
      </doc>
    </add>
  </xsl:template>
</xsl:stylesheet>
