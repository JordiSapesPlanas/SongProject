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

    <%@include file="header.jsp" %>

</head>
<body>
<%@include file="bar.jsp" %>


        <c:if test="${not empty SongCollection}">
            <h1>Music list</h1>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>
                            Name
                    </th>

                    <th>
                            User mail
                    </th>

                    <th>

                    </th>

                </tr>
                </thead>

            <c:forEach var="song" items="${SongCollection}">
                <tbody>
                <tr>
                    <td> ${fn:escapeXml(song.getName())}
                    </td>
                    <td>
                            ${fn:escapeXml(song.getEmail())}
                    </td>
                    <td>
                        <a href="/songCollection/${fn:escapeXml(song.getId())}"> More </a>
                    </td>
                </tr>
                </tbody>
            </c:forEach>
            </table>
        </c:if>
    <br>
    <div style="text-align: center" >
        <button type="button" class="btn btn-primary" onclick="location.href='/songCollection/form'"> Create your List</button>
    </div>



</body>
</html>
