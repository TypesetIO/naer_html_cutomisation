<?xml version='1.0'?>
<!-- ******************************************************** -->
<!--                                                          -->
<!--  converter for NAER HTML customisation                   -->
<!--                                                          -->
<!-- ******************************************************** -->
<!DOCTYPE xsl:stylesheet [ ]>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink" 
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  version="2.0"
>

  <xsl:output method="html" 
   encoding="UTF-8"
   indent="yes"
  />

  <xsl:strip-space elements="*"/>

	<xsl:template match="node()|@*">
  	<xsl:copy>
	  	<xsl:apply-templates select="node()|@*"/>
	  </xsl:copy>
  </xsl:template>

  <xsl:template match="head"/>
  <xsl:template match="header"/>

  <xsl:template match="html">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="article">
    <xsl:element name="article">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="main">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="section">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="section/h2">
    <xsl:element name="h1">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="section/section/h3">
    <xsl:element name="h2">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="section/section/section/h4">
    <xsl:element name="h3">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="section/section/section/section/h5">
    <xsl:element name="h4">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="section/section/section/section/section/h6">
    <xsl:element name="h5">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="p">
    <xsl:if test="text()">
      <xsl:element name="p">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="a">
    <xsl:choose>
      <xsl:when test="@class='xref xref-table' 
        or @class='xref xref-fn'
        or @class='xref xref-fig'
        ">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="a">
          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="@data-jats-ref-type='bibr'">
                <xsl:value-of select="'#'"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:if test="@data-jats-ref-type='bibr'">
            <xsl:attribute name="id">
              <xsl:call-template name="findID">
                <xsl:with-param name="rid" select="@data-jats-rid"/>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="ol">
    <xsl:element name="ol">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="ul">
    <xsl:choose>
      <xsl:when test="@class='ref-list'">
        <xsl:element name="ol">
          <xsl:attribute name="id">
            <xsl:value-of select="'references'"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="ul">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="findID">
    <xsl:param name="rid"/>
    <xsl:for-each select="//ul[@class='ref-list']/li">
      <xsl:if test="div[@id=$rid]">
        <xsl:value-of select="concat('bib', count(preceding-sibling::li) + 1)"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>


  <xsl:template match="i">
    <xsl:element name="i">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="b">
    <xsl:element name="b">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sup">
    <xsl:element name="sup">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="sub">
    <xsl:element name="sub">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="li">
    <xsl:element name="li">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="figure">
    <xsl:choose>
      <xsl:when test="@class='table-wrap'">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="figure">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="figure[@class='table-wrap']/div[@class='caption']/div[@class='title']"/>
  <xsl:template match="figure[@class='table-wrap']/div[@class='caption']/div[@class='title']" mode="here">
    <xsl:element name="caption">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="img">
    <xsl:element name="img">
      <xsl:attribute name="src">
        <xsl:value-of select="tokenize(@src, '/')[last()]"/>
      </xsl:attribute>
      <xsl:attribute name="alt">
        <xsl:value-of select="''"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="figcaption">
    <xsl:element name="figcaption">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="colgroup">
  </xsl:template>

  <xsl:template match="thead">
    <xsl:element name="thead">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="th">
    <xsl:element name="th">
      <xsl:if test="@colspan">
        <xsl:attribute name="colspan">
          <xsl:value-of select="@colspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="td">
    <xsl:element name="td">
      <xsl:if test="@colspan">
        <xsl:attribute name="colspan">
          <xsl:value-of select="@colspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tbody">
    <xsl:element name="tbody">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tr">
    <xsl:element name="tr">
      <xsl:if test="@rowspan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@rowspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="table">
    <xsl:element name="table">
      <xsl:apply-templates select="../../div[@class='caption']/div[@class='title']" mode="here"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="blockquote">
    <xsl:element name="blockquote">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="footer">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="br">
    <xsl:text>&#x0A;</xsl:text>
  </xsl:template>

  <xsl:template match="div">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="span">
    <xsl:apply-templates/>
  </xsl:template>


</xsl:stylesheet>
