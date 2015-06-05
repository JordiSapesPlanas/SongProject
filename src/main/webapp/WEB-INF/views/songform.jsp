<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <title>

        <c:if test="${song.getId()>=0}">
         update song
        </c:if>
        <c:if test="${song.getId()<0}">
            search Song
        </c:if>
    </title>
    <%@include file="header.jsp" %>

</head>
<body>
<%@include file="bar.jsp" %>
    <c:choose>
        <c:when test="${song.getId()>=0}">
            <h3>Update Song</h3>
            <c:set var="method" value="PUT"/>
            <c:set var="action" value="javascript:history.back()/"/>

        </c:when>
        <c:otherwise>
            <h3>Search Song</h3>
            <c:set var="method" value="GET"/>
            <c:set var="action" value="search"/>
        </c:otherwise>
    </c:choose>

    <form:form method="${method}" action="${action}" modelAttribute="song">
        <table>
            <tr>
                <td><form:label path="name">Name</form:label></td>
                <td><form:input path="name"/> <i><form:errors path="name"></form:errors></i></td>
            </tr>
            <tr>
                <c:if test="${song.getId()>=0}">
                <td><form:label path="band">Band</form:label></td>
                <td><form:input path="band"/> <i><form:errors path="band"></form:errors></i></td>
                </c:if>
                <c:if test="${song.getId()<0}">

                    <td><form:input path="band" value=""/></td>
                </c:if>
            </tr>
            <tr>
                <td><input type="submit" value="Submit" /></td>
            </tr>
        </table>
    </form:form>
</body>
</html>
