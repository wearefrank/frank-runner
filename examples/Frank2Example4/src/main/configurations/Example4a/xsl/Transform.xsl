<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<xsl:element name="TransformedResult">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>