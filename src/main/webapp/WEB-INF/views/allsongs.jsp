<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: davidkaste
  Date: 23/02/15
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Song list</title>
</head>
<body>
    <h2>Song list</h2>
    <ul>
        <c:if test="${not empty map.songs}">
            <c:forEach var="song" items="${map.songs}">
                <li>
                    <a href="songs/${song.getId()}">Song ${fn:escapeXml(song.getName())}</a>:

                    <ul>
                        <li>
                            ${fn:escapeXml(song.getName())} - ${fn:escapeXml(song.getBand())}
                        </li>
                        <li>
                            <a href="songs/${song.getId()}/form">Edit Song</a>
                        </li>
                    </ul>
                </li>
            </c:forEach>
        </c:if>

    </ul>
    <a href="/songCollection/${map.idCollection}"> return </a>
    <a href="songs/form">New Song</a>
</body>
</html>
