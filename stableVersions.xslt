<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/xpath-functions">
  <xsl:output omit-xml-declaration="yes" media-type="text"></xsl:output>
  <xsl:template match="/">
    <xsl:apply-templates select="/metadata/versioning/versions/version"></xsl:apply-templates>
  </xsl:template>
  <xsl:template match="version">
    <xsl:if test="not(contains(text(),'-'))"><xsl:value-of select="."/>,</xsl:if>
  </xsl:template>
  <xsl:template match="@*|node()"/>
</xsl:stylesheet>
