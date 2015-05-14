<%--
  Created by IntelliJ IDEA.
  User: debian-jordi
  Date: 4/05/15
  Time: 16:23
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
    <h1>Song Collection</h1>
    <ul>
        <c:if test="${not empty SongCollection}">

            <c:forEach var="song" items="${SongCollection}">
                <li>
                    <a href="/songCollection/${fn:escapeXml(song.getId())}"> ${fn:escapeXml(song.getName())}</a>:

                    <ul>
                        <li>
                            User email: ${fn:escapeXml(song.getEmail())}
                        </li>

                    </ul>
                </li>
            </c:forEach>
        </c:if>
    </ul>
    <a href="/songCollection/form">New Song List</a>

</body>
</html>
