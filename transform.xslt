<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output omit-xml-declaration="yes" indent="yes" />
    <xsl:strip-space elements="*" />

    <xsl:template match="/">
        <charlesSession>
            <xsl:for-each select="/charles-session/transaction[contains(@host, 'lambda')]">
                <transaction>
                    <xsl:choose>
                        <xsl:when test="contains(@path,'upload-url')">
                            <type>GET_URL</type>
                            <xsl:analyze-string select="@query" regex="fileName=(.+\.[a-zA-Z]+)">
                                <xsl:matching-substring>
                                    <fileName>
                                        <xsl:value-of select="regex-group(1)" />
                                    </fileName>
                                </xsl:matching-substring>
                            </xsl:analyze-string>
                        </xsl:when>
                        <xsl:when test="contains(@host,'lambda-storage')">
                            <type>UPLOAD</type>                            
                            <fileId>
                                <xsl:value-of select="replace(replace(@path, 'photos', '_'), '/', '')" />
                            </fileId>
                        </xsl:when>
                        <xsl:when test="contains(@path,'gallery/job')">
                            <type>JOB_TRACKING</type>
                        </xsl:when>
                        <xsl:otherwise>
                            <type>UNKNOWN</type>
                        </xsl:otherwise>
                    </xsl:choose>
                    <start>
                        <xsl:value-of select="@startTime" />
                    </start>
                    <end>
                        <xsl:value-of select="@endTime" />
                    </end>
                    <status>
                        <xsl:value-of select="@status" />
                    </status>
                    <method>
                        <xsl:value-of select="@method" />
                    </method>
                    <host>
                        <xsl:value-of select="@host" />
                    </host>
                    <path>
                        <xsl:value-of select="@path" />
                    </path>
                    <query>
                        <xsl:value-of select="@query" />
                    </query>
                    <xsl:apply-templates select="response" />
                </transaction>
            </xsl:for-each>
        </charlesSession>
    </xsl:template>

    <xsl:template match="response">
        <response>
            <xsl:value-of select="@status" />
        </response>
        <xsl:apply-templates select="body" />
    </xsl:template>

    <xsl:template match="body">
        <xsl:if test="@decoded = 'true'">
            <json>
                <xsl:value-of select="." />
            </json>
            <xsl:analyze-string select="." regex="&quot;fileId&quot;:&quot;([^&quot;]+)&quot;">
                <xsl:matching-substring>
                    <fileId>
                        <xsl:value-of select="regex-group(1)" />
                    </fileId>
                </xsl:matching-substring>
            </xsl:analyze-string>
            <xsl:analyze-string select="." regex="&quot;jobId&quot;:&quot;([^&quot;]+)&quot;">
                <xsl:matching-substring>
                    <jobId>
                        <xsl:value-of select="regex-group(1)" />
                    </jobId>
                </xsl:matching-substring>
            </xsl:analyze-string>
            <xsl:analyze-string select="." regex="&quot;status&quot;:&quot;([a-zA-Z]+)&quot;">
                <xsl:matching-substring>
                    <jobStatus>
                        <xsl:value-of select="regex-group(1)" />
                    </jobStatus>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>