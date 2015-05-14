<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
    <head>
        <title>Song</title>
    </head>
    <body>
        <h3>Song:</h3>
        <p>${fn:escapeXml(song.getName())} - ${fn:escapeXml(song.getBand())}</p>
        <a href="/songs">Return to list</a>
    </body>
</html>