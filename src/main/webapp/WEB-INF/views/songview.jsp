<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>



<html>
    <head>
        <title>Song</title>
        <%@include file="header.jsp" %>
    </head>
    <body>
    <%@include file="bar.jsp" %>
        <h3>Song: ${fn:escapeXml(map.song.getName())}</h3>
        <p>${fn:escapeXml(map.song.getName())} - ${fn:escapeXml(map.song.getBand())}</p>
        <a href="/songCollection/${fn:escapeXml(map.idCollection)}/songs">Return to list</a>
    </body>
</html>