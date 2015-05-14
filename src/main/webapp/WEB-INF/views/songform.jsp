<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <title>Song Form</title>
</head>
<body>
    <c:choose>
        <c:when test="${song.getId()>=0}">
            <h3>Update Greeting</h3>
            <c:set var="method" value="PUT"/>
            <c:set var="action" value="songs/${song.getId}"/>
        </c:when>
        <c:otherwise>
            <h3>Create Song</h3>
            <c:set var="method" value="POST"/>
            <c:set var="action" value="songs/"/>
        </c:otherwise>
    </c:choose>

    <form:form method="${method}" action="${action}" modelAttribute="song">
        <table>
            <tr>
                <td><form:label path="name">Name</form:label></td>
                <td><form:input path="name"/> <i><form:errors path="name"></form:errors></i></td>
            </tr>
            <tr>
                <td><form:label path="band">Band</form:label></td>
                <td><form:input path="band"/> <i><form:errors path="band"></form:errors></i></td>
            </tr>
            <tr>
                <td><input type="submit" value="Submit" /></td>
            </tr>
        </table>
    </form:form>
</body>
</html>
