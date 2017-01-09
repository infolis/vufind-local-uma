<?xml version="1.0" encoding="UTF-8"?>
<!-- vim: set sw=2:ts=2: -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:php="http://php.net/xsl"
  xmlns:oai="http://www.openarchives.org/OAI/2.0/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xlink="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:doaj="http://www.doaj.org/schemas/">
  <xsl:output method="xml" indent="yes" encoding="utf-8"/>
  <xsl:template match="text()"></xsl:template>

  <xsl:template match="/">
    <add>
      <doc>
        <field name='collection'>SSOAR</field>

        <xsl:for-each select=".//dc:contributor">
          <field name="author_additional">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <!-- <xsl:for-each select=".//dc:coverage"> -->
          <!--   <field name="TODO"> -->
            <!--     <xsl:value-of select="."/> -->
            <!--   </field> -->
          <!-- </xsl:for-each> -->

        <xsl:for-each select=".//dc:creator[1]">
          <field name="author">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select=".//dc:creator[position()>1]">
          <field name="author2">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select=".//dc:date">
          <field name="publishDate">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>	

        <!-- <xsl:for-each select=".//dc:description"> -->
          <!--   <field name="description"> -->
            <!--     <xsl:value-of select="."/> -->
            <!--   </field> -->
          <!-- </xsl:for-each> -->

        <!-- <xsl:for-each select=".//dc:format"> -->
          <!--   <datafield tag="856" ind1=" " ind2=" "> -->
            <!--     <subfield code="q"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <xsl:for-each select=".//dc:identifier[substring(.,1,3) = 'urn']">
          <field name="id">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>
        <xsl:for-each select=".//dc:identifier[substring(.,1,4) = 'http']">
          <field name="url">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <!-- <xsl:for-each select=".//dc:language"> -->
          <!--   <datafield tag="546" ind1=" " ind2=" "> -->
            <!--     <subfield code="a"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <xsl:for-each select=".//dc:pubLink">
          <field name="url">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>


        <xsl:for-each select=".//dc:publisher">
          <field name="publisher">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <!-- <xsl:for-each select=".//dc:relation"> -->
          <!--   <datafield tag="787" ind1="0" ind2=" "> -->
            <!--     <subfield code="n"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <!-- <xsl:for-each select=".//dc:rights"> -->
          <!--   <datafield tag="540" ind1=" " ind2=" "> -->
            <!--     <subfield code="a"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <!-- <xsl:for-each select=".//dc:source"> -->
          <!--   <datafield tag="786" ind1="0" ind2=" "> -->
            <!--     <subfield code="n"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <!-- <xsl:for-each select=".//dc:subject"> -->
          <!--   <datafield tag="653" ind1=" " ind2=" "> -->
            <!--     <subfield code="a"> -->
              <!--       <xsl:value-of select="."/> -->
              <!--     </subfield> -->
            <!--   </datafield> -->
          <!-- </xsl:for-each> -->

        <xsl:for-each select=".//dc:title[1]">
          <field name="title">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select=".//dc:title[position()>1]">
          <field name="title_sub">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>

        <xsl:for-each select=".//dc:type">
          <field name="format">
            <xsl:value-of select="."/>
          </field>
        </xsl:for-each>
      </doc>
    </add>
  </xsl:template>
</xsl:stylesheet>
