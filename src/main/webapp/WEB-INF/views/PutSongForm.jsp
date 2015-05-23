<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
  <title>


      update song
  </title>
</head>
<body>


    <h3>Update Song</h3>

<form:form method="PUT" action="/songCollection/${map.idCollection}/songs/${map.song.getId()}">
  <table>
    <tr>

      <td> Name <input type="text" name="name" value="${map.song.getName()}"/></td>
    </tr>
    <tr>
       <td> Band <input type="text" name="band" value="${map.song.getBand()}"/></td>
    </tr>
    <tr>

      <td><input type="submit" value="Submit" /></td>
    </tr>
  </table>
</form:form>
</body>
</html>
