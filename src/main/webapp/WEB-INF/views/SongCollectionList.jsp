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
    <link rel="stylesheet" href="../../mystyle.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"/>


</head>
<body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">Lists</a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="/">Home</a></li>
                    <li><a href="/songCollection/form">Create your List</a></li>

                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </nav>

    <h1>Music list</h1>
    </div>
        <c:if test="${not empty SongCollection}">
            <table align="center">
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



</body>
</html>
