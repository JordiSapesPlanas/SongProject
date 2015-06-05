<%--
  Created by IntelliJ IDEA.
  User: debian-jordi
  Date: 4/05/15
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <title> Create your song</title>
    <%@include file="header.jsp" %>

</head>
<body>
<%@include file="bar.jsp" %>
    <header> Create a new collection of Song!</header>

 <form:form method="POST" action="/songCollection" modelAttribute="SongCollection">
        <p><form:label path="email">Email</form:label>

            <form:input path="email"/> <i><form:errors path="email"></form:errors></i>
        </p>
        <p>
            <form:label path="name">Name</form:label>
            <form:input path="name"/> <i><form:errors path="name"></form:errors></i>
        </p>
     <input type="submit" value="Submit" />
</form:form>
</body>
</html>
