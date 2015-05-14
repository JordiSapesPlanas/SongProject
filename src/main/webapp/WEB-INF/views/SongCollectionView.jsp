<%--
  Created by IntelliJ IDEA.
  User: debian-jordi
  Date: 13/05/15
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Song Collection</title>
</head>
<body>

    <c:if test="${not empty SongCollection}">
        <h1>Song Collection ${fn:escapeXml(SongCollection.getName())}</h1>
                <p>User email: ${fn:escapeXml(SongCollection.getEmail())}
                    <a href="/songCollection/${fn:escapeXml(SongCollection.getId())}/songs">  View songs  </a>
                </p>
                <br>

        <a href="/songCollection/">   Return to list  </a>:

    </c:if>
    <c:if test="${empty SongCollection}">
        <p>Song collection not exists</p>
    </c:if>


</body>
</html>
